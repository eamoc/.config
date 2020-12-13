#!/bin/bash
#Post-install Script for my void distribution

#Update the packages to the most recent version 

printf "\n\nUpdating packages to latest version\n\n"
sudo xbps-install -Suvy


#Download some required packages:
printf "\nDownloading some required packages\n\n"
printf "\nInstalling the Xorg server, input drivers and a few additional utilities\n\n"                 		
sudo xbps-install -Svy xorg-minimal
printf "\nInstalling Basic font files and font encoding utilites\n\n"
sudo xbps-install -Svy xorg-fonts						  
printf "\nInstalling xterm emulator\n\n"
sudo xbps-install -Svy xterm					
printf "\nInstalling clock for twm\n\n"
sudo xbps-install -Svy clock				
printf "\nInstalling basic window wanager\n\n"
sudo xbps-install -Svy twm					
printf "\nInstalling Terminal multiplexer\n\n"
sudo xbps-install -Svy tmux					
printf "\nInstalling AMD video driver\n\n" 
sudo xbps-install -Svy xfree86-video-amdgpu
printf "\nInstalling Source code control versioning system\n\n"
sudo xbps-install -Svy git				
printf "\nInstalling THE text editor :-)\n\n"
sudo xbps-install -Svy vim				
printf "\nInstalling location db and lookup utilities\n\n"
sudo xbps-install -Svy mlocate			
printf "\nInstalling a simple image viewer\n\n"
udo xbps-install -Svy feh				
printf "\nInstalling a utility for displaying window and font properties in an X server\n\n"
sudo xbps-install -Svy xprop				
printf "\nInstalling a utility that sets the size orientation and/or the reflection of the outputs for a screen. It can also set the screen size\n\n"
sudo xbps-install -Svy xrandr			
printf "\nInstalling a visual front end for arandr\n\n"
sudo xbps-install -Svy arandr			
printf "\nInstalling xrvt-unicode terminal editor\n\n"
sudo xbps-install -Svy xrvt-unicode			
printf "\nInstalling GNU compiler and associated development utilities\n\n"
sudo xbps-install -Svy base-devel			
printf "\nInstalling IRC chat client\n\n"
sudo xbps-install -Svy irssi					
printf "\nInstalling Graphic image manipulation program\n\n"
sudo xbps-install -Svy gimp				
printf "\nInstalling text based music player\n\n"
sudo xbps-install -Svy cmus					
printf "\nInstalling GUI based bittorrent client\n\n"
sudo xbps-install -Svy qbittorrent				
printf "\nInstalling Advanced Linux Sound Architercture files and utilities\n\n"
sudo xbps-install -Svy alsa-utils				
printf "\nInstalling Curl command line downloading tool\n\n"
sudo xbps-install -Svy curl				
printf "\nInstalling Wget. It's similar to Curl\n\n" 
sudo xbps-install -Svy wget					

#Setup the Source packages tree
printf "Setting up the source packages tree"
cd ~
git clone git://github.com/void-linux/void-packages.git
cd void-packages
./xbps-src binary-bootstrap
