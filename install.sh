#!/bin/bash

# Installing System Dependencies
if [ "$(uname)" = "Darwin" ]; then
  cat ./dependencies/os-mac.txt | xargs brew install
elif grep '^ID=.*opensuse' /etc/os-release > /dev/null; then
  sudo zypper install $(cat ./dependencies/os-linux.txt)
elif grep '^ID=arch' /etc/os-release > /dev/null; then
  sudo pacman -S --needed $(cat ./dependencies/os-linux.txt)
else
  echo 'Unsupported OS.'
  exit 1
fi

# Installing Fred's ImageMagick Scripts
mkdir ./lib
cat ./dependencies/lib.txt | xargs -I {} \
  wget -O ./lib/{} 'http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname={}&dirname={}'
chmod +x ./lib/*
