#!/usr/bin/env python

import sys
secs = int(sys.argv[1])
mins = secs // 60
hours = mins // 60
days = hours // 24

show_days = days > 0
show_seconds = not show_days

if show_days:
    print(f'{days}d', end=' ')
print(f'{hours % 24}h {mins % 60}m', end='')
if show_seconds:
    print(f' {secs % 60}s')
else:
    print()
