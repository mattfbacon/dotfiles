# Dotfiles

Split into three directories:

- `desktop` and `framework`: for their eponymous platforms.
- `shared`: for both platforms. no need to stow from this directory as its contents are symlinked into both `desktop` and `framework`.

To install, in the directory for the platform:

```bash
stow -t ~ -v (find -maxdepth 1 -mindepth 1 -xtype d -not -name '.*' -printf '%P\n')
```

## Other System Considerations

Disable your ISP's awful DNS:

1. Install `dnsmasq`.
1. Disable and stop `systemd-resolved` or whatever other resolver may be running currently.
1. Put this in `/etc/dnsmasq.conf`:

```
listen-address=::1,127.0.0.1
cache-size=10000
conf-file=/usr/share/dnsmasq/trust-anchors.conf
dnssec
no-resolv
server=1.1.1.1
server=1.0.0.1
server=2606:4700:4700::1111
server=2606:4700:4700::1001
expand-hosts
```

1. Enable and start `dnsmasq`.
1. Put this in `/etc/NetworkManager/conf.d/dns.conf`:

```
[main]
# completely ignore the DNS provided by the ISP
dns=none
rc-manager=unmanaged
```

1. Ensure that `/etc/resolv.conf` is not a symlink, and then put this in it:

```
nameserver ::1
nameserver 127.0.0.1
options trust-ad
```

1. Ensure that you have configured everything correctly by running `dig archlinux.org`. Verify that `SERVER: ::1#53(::1) (UDP)` or the IPv4 equivalent is present in the output.
