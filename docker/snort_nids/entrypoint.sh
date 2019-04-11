#!/bin/sh

set -e

/usr/sbin/sshd -D &
snort -dv -h 10.0.0.0/24 -l /var/log/snort -c /etc/snort/snort.conf
