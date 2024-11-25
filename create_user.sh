#!/bin/env bash
set -e

USERNAME=$1
if [ -z "$USERNAME" ]; then
    echo "Missing username argument"
    exit
fi

useradd -G "wheel,audio,video,storage,scanner,network,socklog,input,rtkit,bluetooth,docker" -m --shell /bin/zsh $USERNAME
sudo -u $USERNAME cp -r home-dir/* /home/$USERNAME/
# Hidden folders aren't copied by `cp` recursively
sudo -u $USERNAME cp -r home-dir/.config /home/$USERNAME/
