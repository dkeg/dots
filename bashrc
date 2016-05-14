# ~/.bashrc: executed by bash(1) for non-login shells.

## using this so tmux isn't fucked up
TERM='screen-256color'

## Turn of stty manual (XON,XOFF). Legacy is CTRL-S prevents input/output
## and CTRL-Q resumes.  
## now CTRL-S will work with bash's incremental search feature
stty -ixon

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
  # prompt options
  p="━━━"
  #p="──"
  #p="──━"
  #p="»"
  #p="¯" #drift
   
    PS1="\[\$(/home/dkeg/bin/promptd)\]  $p  \[\e[0m\]"
else
    PS1='  $p  ' 
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################## functions ##################

function wtf(){
STERM=$1
dpkg -l|grep ii|grep $TERM|awk '{system("whereis "$2);$1="";$3=$4=""; print
$0}'
}

# Automatically do an ls after each cd
cd() {
    builtin cd $@ && ls
}

#cd() {
#  if [ -n "$1" ]; then
#builtin cd "$@" && ls --group-directories-first
#  else
#builtin cd ~ && ls --group-directories-first
#  fi
#}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## COLOR MAN PAGES
function man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# quick color view and code
function colorit() {
    #color=$1
    color=$(awk 'NR==5{gsub(/</," ");gsub(/>/," ");print $2}' $HOME/.Xresources.d/.colors | cut -d '/' -f5)
    doit="cat /home/dkeg/colors/$color"
    #doit="cat /home/dkeg/colors/$1"
    usage() {
        echo "usage colorit 'color file'"
    }
    #test -n "$1" || usage
        #if [ ! -z $1 ];then
        if [ ! -z $color ];then
            colors && $doit
        else
            echo 'add the color file'
        fi
}
# up directory; replace cd ../..; usage up, up 2, so on
function up() {
    local d=""
    limit=$1
    for ((i=1; i <= limit; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

function gitpush() {
    # usage: gitpush [ . |"files"] ["commit message"] [branchname]  
    # gitpush newfile 'add new file' master
    args=("$@")
        git add ${args[0]} && git commit -m "${args[1]}" && git push -u origin ${args[2]}
}

# quickly add a wall to .xinitrc;adjust as needed
# usage: wallput [tile|fill] [wall] [option] [option]
# example: wallput fill wall.jpg '-blur 10'
function wallput() {
    #file=$HOME/.testrc
    file=$HOME/.xinitrc
    path=/data/walls/
    cur=$(cat $file|grep hsetroot|awk '{print $1}') #'|cut -d '-' -f1)
    line=$(awk '/hsetroot/{ print NR; }' $file)
    args=("$@")
         #sed -i "/$cur/d" $file            #replace current
         sed -i "/$cur/s/^/# /" $file       #comment current
         wall="hsetroot -${args[0]} $path${args[@]:1} &"
         new="${line} $wall"
         echo $new
         #sed -i "${new}" $file
         sed -i "${line}i hsetroot -${args[0]} $path${args[1]} ${args[2]} ${args[3]} &" $file
         #sed -i "${line}i hsetroot -${args[0]} $path${args[@]:1} &" $file
         #$wall
}
function walladd() {
    file=$HOME/.xinitrc
    cur=$(cat $file|grep hsetroot) #|awk '{print}')
    args=("$@")
        ## manual method; need to add line# and comment out old 
        sed -i "${args[0]}i hsetroot -${args[1]} /data/walls/${args[2]} ${args[3]} &" $file
}

# Upload a config to sprunge and give me a link
function spr() {
    echo "cat $1 | curl -F 'sprunge=<-' http://sprunge.us"
    cat $1 | curl -F 'sprunge=<-' http://sprunge.us
}

# give me a tinyurl
function tiny() {
    curl -sf http://tinyurl.com/api-create.php?url="$1";
    echo
}

# pac <packagename> shows package information on the Debian site

function pac() { 
links https://packages.debian.org/en/sid/"$@" ;
}

# bug <packagename> opens the bug tracker. For those who don't have apt-listbugs
function bug() { 
links http://bugs.debian.org/"$@" ;
}

function colors() {
clear

WIDTH=`tput cols`
HEIGHT=`tput lines`
h=`expr $HEIGHT / 2`
NUMBARS=8
BARWIDTH=`expr $WIDTH / $NUMBARS`

l="1"

#while [ "$l" -lt $HEIGHT ]; do
while [ "$l" -lt $h ]; do
    b="0"
    while [ "$b" -lt $NUMBARS ]; do
        s="0"
        while [ "$s" -lt $BARWIDTH ]; do
            echo -en "\e[3"$b"m█"
            s=`expr $s + 1`
        done
        b=`expr $b + 1`
    done
#        echo
    l=`expr $l + 1`
    echo
done
}

##################### end functions ###################
GIT_PS1_SHOWDIRTYSTATE=true
export HISTCONTROL=ignoredups
#COLUMNS=250
#!source .shell_prompt.sh
# MUTT BACKGROUND FIX
COLORFGBG="default;default"

export PATH=/home/dkeg/dirtydots:$PATH
export PATH=/home/dkeg/bin:$PATH
export PATH=/home/dkeg/git:$PATH
export PATH=/home/dkeg/wmtls:$PATH
export PATH=/data/configs/wmtls:$PATH
export PATH=/home/dkeg/.configs/bspwm/scripts:$PATH


PATH="/home/dkeg/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/dkeg/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dkeg/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dkeg/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dkeg/perl5"; export PERL_MM_OPT;
