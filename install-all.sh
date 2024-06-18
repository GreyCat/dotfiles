#!/bin/sh -ef

. /etc/os-release

# Install modern fish

if [ "$ID" = ubuntu ]; then
    # https://launchpad.net/~fish-shell/+archive/ubuntu/release-3
    sudo apt-add-repository --yes ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install fish

    sudo chsh -s /usr/bin/fish "$USER"
fi

# Create symlinks for /c and /w
for drive in c w; do
    if [ -r /mnt/$drive ] && [ ! -r /$drive ]; then
        echo "Creating symlink for /$drive"
        sudo ln -sf /mnt/$drive /$drive
    fi
done
