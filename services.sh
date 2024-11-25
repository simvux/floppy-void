#!/bin/env bash
set -e

USERNAME=$1
if [ -z "$USERNAME" ]; then
    echo "Missing username argument"
    exit
fi

ln -s /etc/sv/polkitd /var/service/
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/udiskie /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/rtkit /var/service/
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanosocklogd /var/service/
ln -s /etc/sv/NetworkManager /var/service/
ln -s /etc/sv/runsvdir-$USERNAME /var/service/
