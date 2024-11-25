#!/bin/env bash
set -x

USERNAME=$1
if [ -z "$USERNAME" ]; then
    echo "Missing username argument"
    exit
fi

echo "Hooking up user-local hooks to system-wide hooks"
grep -qxF "su - $USERNAME -c /home/$USERNAME/app/system/on-shutdown" /etc/rc.shutdown || echo "su - $USERNAME -c /home/$USERNAME/app/system/on-shutdown" >> /etc/rc.shutdown
grep -qxF "su - $USERNAME -c /home/$USERNAME/app/system/on-boot" /etc/rc.local || echo "su - $USERNAME -c /home/$USERNAME/app/system/on-boot" >> /etc/rc.local

echo "Installing ZSH plugin manager"
sudo -u simon git clone --depth=1 https://github.com/mattmc3/antidote.git /home/$USERNAME/.antidote

echo "Installing GEF plugin for GDB"
sudo -u simon wget -O /home/$USERNAME/app/gdbinit-gef.py -q https://gef.blah.cat/py

echo "Installing unipicker"
git clone https://github.com/jeremija/unipicker.git
cd unipicker
make install
cd ..
rm -rf unipicker
