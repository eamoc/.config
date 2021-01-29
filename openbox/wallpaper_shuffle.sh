 #! /usr/bin/env sh

#loads a random desktop wallpaper
 WALLPAPERS="/home/eamoc/.config/backgroundImages"

 desktop_bg=$(find "$WALLPAPERS" -type f | shuf | head -n 1) &&
 exec feh --bg-scale "$desktop_bg"
