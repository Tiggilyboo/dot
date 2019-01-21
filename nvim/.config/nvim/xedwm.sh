#!/bin/bash
if [[ ! $(command -v i3) ]]; then
  echo "Missing package i3, installing..."
  sudo apt-get -q update
  sudo apt-get -yq install i3
fi  

echo "Killing xfce4, starting i3..."
sudo pkill xfwm4
sudo pkill xfdesktop
sudo pkill xfce4-panel
sudo pkill i3

DIR="$(dirname "$(readlink -f "$0")")"
xrandr --dpi 231
exec i3 -c "$DIR/wm/i3.config" &
