#!/bin/env bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

xbps-install -Su void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree

xbps-install -y -Su zsh pipewire wireplumber bluez ImageMagick MangoHud NetworkManager Vulkan-Headers \
    alacritty base-devel boost-devel cairo cairo-devel calf calibre chrony cmake dbus dmidecode \
    dolphin efitools elogind efibootmgr ffmpeg firefox font-awesome font-awesome5 font-awesome6 \
    fonts-roboto-ttf radare2 gdb git curl wget go gopls gstreamer-vaapi htop iotop hyprwayland-scanner \
    intel-ucode inotify-tools kdeconnect libOSMesa libXcomposite libXrender libXft-32bit libavcodec \
    libavformat libavutil libinput libreoffice libva-utils lxd docker mesa mesa-32bit mesa-dri \
    mesa-dri-32bit mesa-opencl mesa-vaapi mesa-vaapi-32bit mesa-vdpau mesa-vulkan-overlay-layer \
    mesa-vulkan-overlay-layer-32bit mesa-vulkan-radeon mesa-vulkan-radeon-32bit meson mpd vlc \
    msr-tools nasm ncdu ncpamixer neovim nerd-fonts net-tools nftables noto-fonts-ttf noto-fonts-ttf-extra \
    nvtop obs obs-plugin-browser-bin ohsnap-font p7zip pango pavucontrol polkit protonvpn-cli \
    qpwgraph qt6-wayland qt5-wayland radeontop ranger rtkit rustup slurp socklog-void socklog \
    source-sans-pro steam svt-av1 terminus-font termsyn-font tokei tmux zellij tree udiskie \
    ttf-ubuntu-font-family unison unrar vulkan-loader vulkan-loader-32bit wayland-protocols mako \
    wf-recorder wf-shell wget wine whois wl-clipboard wofi xdg-desktop-portal-gtk xev xtools \
    xdg-desktop-portal-wlr hyprland hyprpaper hyprland-protocols hyprutils fzf qt5ct qt6ct kvantum
