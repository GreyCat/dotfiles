#!/bin/sh -ef

. /etc/os-release

# Install modern fish

if [ "$ID" = ubuntu ]; then
    # https://launchpad.net/~fish-shell/+archive/ubuntu/release-3
    sudo apt-add-repository --yes ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install -y fish

    sudo chsh -s /usr/bin/fish "$USER"
fi

# Create symlinks for /c and /w
for drive in c w; do
    if [ -r /mnt/$drive ] && [ ! -r /$drive ]; then
        echo "Creating symlink for /$drive"
        sudo ln -sf /mnt/$drive /$drive
    fi
done

# If we're running on Windows machine, try our best to symlink Linux user paths to Windows one
for linkdir in Desktop Documents Downloads; do
    if [ ! -e "$HOME/$linkdir" ] && [ -d "/mnt/c/Users/$USER/$linkdir" ]; then
        ln -s "/mnt/c/Users/$USER/$linkdir" "$HOME/$linkdir"
    fi
done
