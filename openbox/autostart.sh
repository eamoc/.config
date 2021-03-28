#
# These things are run when an Openbox X Session is started.
# You may place a similar script in $HOME/.config/openbox/autostart
# to run user-specific things.
#

# If you want to use GNOME config tools...
#
#if test -x /usr/libexec/gnome-settings-daemon >/dev/null; then
#  /usr/libexec/gnome-settings-daemon &
#elif which gnome-settings-daemon >/dev/null 2>&1; then
#  gnome-settings-daemon &
#fi

# If you want to use XFCE config tools...
#
#xfce-mcs-manager &

#My wallpaper
eval "$(cat $HOME/.fehbg)" &

#Set up the Intro space, Monitors Splash etc.

#Set up the Terminals (on Workspace 2)

#Set up the Hugo workspace (on Workspace 3)
(sleep 3s && xfce4-terminal --geometry 30x20+0+0 --working-directory=$CURRENT_BLOG) &
#(sleep 3s && xfce4-terminal --working-directory=$CURRENT_BLOG) &
#(sleep 3s && xfce4-terminal --working-directory=$CURRENT_BLOG) &
#(sleep 3s && icecat) &

#Launch Discord Client (on Workspace 4)
#(sleep 3s && Discord) &
#Launch Telegram (on Workspace 5)
#(sleep 3s && Telegram) &
#Launch Firefox (on Workspace 6)
#(sleep 3s && firefox) &
#Launch RhythmBox (on Workspace 7)
#(sleep 3s && rhythmbox) &
#Launch qBittorrent (on Workspace 8)
#(sleep 3s && qbittorrent) &
