#!/bin/sh
# .xinitrc file

. $HOME/bin/colr
. $HOME/.bg

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# font bullshit
#xset +fp ~/.fonts
xset +fp /usr/share/fonts/local
xset fp rehash

# source the Xresources for the terminal
xrdb -merge ~/.Xresources &

# Ctrl-Alt-Backspace kills the X session
setxkbmap -option terminate:ctrl_alt_bksp

# sets your keyboard to 'us' keymap
setxkbmap us &

# caps lock to backspace
setxkbmap -option caps:escape

## DPMS monitor setting (standby suspend off)(seconds)
xset dpms 300 600 900 &

## for who the bell tolls (percent;pitch;duration)
## test with xset q | grep bell
xset b 100 400 100

# make the cursor point in the 'right' direction
xsetroot -cursor_name left_ptr &

# set a wallpaper
$wallp

# candy
#compton --config $HOME/.compton.conf --sw-opti &

# hide mouse when inactive
#unclutter &
 
# Status Bar
#sleep 3 && infostats >/dev/null &

# easy on the eyes
#redshift &
#redshift -l 39.95:75.17 &
#redshift -l 39.95:75.17 -t 5500:3600 -g 0.8 &

# date and time
#sleep 2s && closdck &

## notifications
#sleep 5s && while :; do notifs; sleep 650; done &
sleep 5s && while :; do battnotif; sleep 450; done &


# keybinds
#xbindkeys -f ~/.xbindkeysrc &

# urxvt session
sleep 3s && urxvt &
#urxvtd -q -f -o

# Start your window manager using xinit, xinit [wm]
DEFAULTSESSION=none
case "$1" in
        none)     sxhkd -c ~/wmtls/.sxhkdrc &
                  #sleep 2s && infostats &
                  sleep 2s && closdck &
                  #rainbow &
                  wew|fw &
                  exec xwait ;;
        monster)  exec monsterwm ;;
        swm)      exec swm ;;
        cwm)      exec cwm ;;
        hlwm)     exec herbstluftwm ;;
        rat)      exec ratpoison ;;
        spect)    exec spectrwm ;;
        2bwm)     sxhkd -c ~/git/2bwm/.sxhkdrc &
                  sleep 2s && closdck &
                  exec 2bwm ;;
        bspwm)    sxhkd -c ~/.config/bspwm/.sxhkdrc &
                  exec bspwm ;;
        *)        exec $DEFAULTSESSION ;;
esac
