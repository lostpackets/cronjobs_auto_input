#!/bin/bash

# Check the OS
if [ -f /etc/lsb-release ]; then
    # Ubuntu or Debian
    command="sudo apt-get update;sudo apt-get upgrade -y"
elif [ -f /etc/arch-release ]; then
    # Arch Linux
    command="sudo pacman -Syu"
elif [ -f /etc/void-version ]; then
    # Void Linux
    command="xbps-install -Su"
elif [ -f /etc/nixos/configuration.nix ]; then
    # NixOS
    command="nix-channel --update;nixos-rebuild switch --upgrade"
else
    echo "Unknown OS"
    exit 1
fi

# Add the command to crontab
echo "0 4 * * * $command" | crontab -
echo "Updates are set to run every day at 4am."
