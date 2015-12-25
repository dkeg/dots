#!/bin/sh
# .xinitrc file

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# font bullshit
xset +fp /usr/share/fonts/local
xset fp rehash

# source the Xresources for the terminal
xrdb -merge ~/.Xresources &

# Ctrl-Alt-Backspace kills the X session
setxkbmap -option terminate:ctrl_alt_bksp

# sets your keyboard to 'us' keymap
#setxkbmap us &

# caps lock to backspace
setxkbmap -option caps:escape

## DPMS monitor setting (standby suspend off)(seconds)
xset dpms 300 600 900 &

## for who the bell tolls (percent;pitch;duration)
## test with xset q | grep bell
xset b 100 400 100

# make the cursor point in the 'right' direction
xsetroot -cursor_name left_ptr &

# keybinds
sxhkd -c ~/wmtls/.sxhkdrc &
#xbindkeys -f ~/.xbindkeysrc &

# set a wallpaper
$HOME/.bg $

# candy
#compton --shadow-exclude '!focused' --config $HOME/.compton3.conf --sw-opti  &
compton --config $HOME/.compton3.conf --sw-opti &

# hide mouse when inactive
unclutter &
 
# Bar
#sleep 3 && infostat &

# soft on the eyes
#redshift &
#redshift -l 39.95:75.17 &
redshift -l 39.95:75.17 -t 5500:3600 -g 0.8 &

# date and time using osd clock
sleep 2s && closdck &

## notifications
#sleep 5s && while :; do notifs; sleep 650; done &
sleep 5s && while :; do battnotif; sleep 450; done &

#urxvtd -q -f -o

wew | fw &

# Start your window manager using xinit, xinit [wm]
DEFAULTSESSION=none
case "$1" in
        none)     exec xwait ;;
        swm)      exec swm ;;
        cwm)      exec cwm ;;
        hlwm)     exec herbstluftwm ;;
        rat)      exec ratpoison ;;
        spect)    exec spectrwm ;;
        2bwm)     exec 2bwm ;;
        *)        exec $DEFAULTSESSION ;;
        esac
