#!/bin/bash

# Checking if is running in Repo Folder
if [[ "$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" =~ ^scripts$ ]]; then
    echo "You are running this in ArchInstall Folder."
    echo "Please use ./ArchInstall.sh instead"
    exit
fi

# Installing git

echo "Installing git."
pacman -Sy --noconfirm --needed git glibc

echo "Cloning the ArchInstall Project"
git clone https://github.com/wesscd/ArchInstall

echo "Executing ArchInstall Script"

cd $HOME/ArchInstall

exec ./ArchInstall.sh
