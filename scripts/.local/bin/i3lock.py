#!/usr/bin/env python3
from os import system, waitpid
import os
import dbus
import pathlib
import contextlib
from sys import exit
import argparse
from Xlib import display
from time import sleep
import subprocess

class Notify:
    def __init__(self):
        self.notify_interface = dbus.Interface(object=dbus.SessionBus().get_object('org.freedesktop.Notifications', '/org/freedesktop/Notifications'), dbus_interface="org.freedesktop.Notifications")
        self.cookie = None
    def notify(self, txt, timeout=10):
        self.hide()
        self.cookie = self.notify_interface.Notify("", 0, "", "i3lock says", txt, [], {"urgency": 1}, timeout * 1000)
    def hide(self):
        if self.cookie is not None:
            self.notify_interface.CloseNotification(self.cookie)
        self.cookie = None
    close = hide

notify = Notify()

def set_dunst_pause(is_paused):
    subprocess.run(['dunstctl', 'set-paused', 'true' if is_paused else 'false'])

# returns (x, y) of cursor
def cursor_pos():
    data = display.Display().screen().root.query_pointer()._data
    return (data['root_x'], data['root_y'])

# returns: ms the user was inactive as int
def inactive_time():
    data = subprocess.run(['xssstate', '-i'], stdout=subprocess.PIPE).stdout.decode().strip()
    return int(data)

# returns: background color as hex, e.g., "#123456"
def bg_color():
    data = subprocess.run([pathlib.PosixPath('~/.local/bin/getbgcolor.sh').expanduser()], stdout=subprocess.PIPE).stdout.decode().strip()
    return '#' + data

def on_battery():
    with open('/sys/class/power_supply/AC/online', 'r') as f:
        return f.readline().strip() == '0'

def dpms_off():
    subprocess.run(['xset', 'dpms', 'force', 'off'])

def suspend():
    subprocess.run(['systemctl', 'suspend'])

# returns: if inhibited
def inhibited():
    if cursor_pos() == (0, 0):
        return True
    # add more...
    return False

# returns: if the user was inactive
def sleep_with_check(time):
    for i in range(time):
        sleep(1)
        # if the user had activity in this time period (850 ms to give a reasonable buffer, since the actual time would be 1000)
        if inactive_time() < 850:
            return False
    return True


# returns: if the user was inactive
def alert_and_sleep_with_check(time, sub_time=0, incessant=False):
    if incessant:
        for i in range(time, sub_time, -1):
            # if the user was active, exit the loop
            notify.notify(f"System going to sleep in {i} seconds", timeout=1)
            if sleep_with_check(1) == False: return False
        return True
    else:
        notify.notify(f"System going to sleep in {time} seconds", timeout=min(time-sub_time, 10))
        return sleep_with_check(time - sub_time)

# returns: if the user did not stop the dimming process (i.e., was inactive)
def dim():
    FRIENDLY_ALERT_TIME = 30 # seconds
    UNFRIENDLY_ALERT_TIME = 10 # seconds
    INCESSANT_ALERT_TIME = 3 # seconds

    # friendly
    if alert_and_sleep_with_check(FRIENDLY_ALERT_TIME, UNFRIENDLY_ALERT_TIME + INCESSANT_ALERT_TIME) == False: return False

    # unfriendly
    if alert_and_sleep_with_check(UNFRIENDLY_ALERT_TIME, INCESSANT_ALERT_TIME) == False: return False

    # incessant
    if alert_and_sleep_with_check(INCESSANT_ALERT_TIME, incessant=True) == False: return False

    return True

def lock():
    sp = subprocess.Popen(['i3lock', '-n', '-e', '-f', '-c', bg_color()])
    sleep(1)
    dpms_off()

    STAY_OFF_INTERVAL = 1 # seconds
    TIMEOUT_BEFORE_SUSPEND = 15 # seconds

    if on_battery():
        if sleep_with_check(TIMEOUT_BEFORE_SUSPEND) == False: return
    # this is in case the AC state has changed, like if the user plugged in the charger in the interval
    if on_battery():
        suspend()
    else:
        while sleep_with_check(STAY_OFF_INTERVAL):
            dpms_off()
    return sp

@contextlib.contextmanager
def close_notify_on_exit():
    yield
    notify.close()

@contextlib.contextmanager
def pause_dunst():
    set_dunst_pause(True)
    yield
    set_dunst_pause(False)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Lock i3 with indication, etc")
    parser.add_argument('-n', '--no-dim', action='store_false', dest='dim')
    parser.add_argument('-d', '--dim', action='store_true', dest='dim')
    args = parser.parse_args()

    with close_notify_on_exit():
        if args.dim and (inhibited() or not dim()):
            return
    with pause_dunst();
        lock_pid = lock().pid
        waitpid(lock_pid, os.WUNTRACED)
