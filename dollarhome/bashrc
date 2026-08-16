#
# ~/.bashrc
#
# All lines start with a space so history ignores them
# If not running interactively, don't do anything
 [[ $- != *i* ]] && return
 
 CS_RST='\e[0m'
 CS_BLK='\e[0;30m'
 CS_RED='\e[0;31m'
 CS_GRN='\e[0;32m'
 CS_YEL='\e[0;33m'
 CS_BLU='\e[0;34m'
 CS_MAG='\e[0;35m'
 CS_CYA='\e[0;36m'
 CS_WHT='\e[0;37m'
 
 localstuff=.localrc
 bashcomp=/usr/share/bash-completion/bash_completion
 
 set -o history
 shopt -qs histappend
 HISTSIZE=100000
 HISTCONTROL=ignorespace:ignoredups:erasedups
 
 [[ -f $localstuff ]]	&& source $localstuff
 [[ -f $bashcomp ]]	&& source $bashcomp
 
 alias ls='ls --color=auto'
 alias grep='grep --color=auto'
 alias tree="tree -C"
 alias du='du -h'
 
 PS1="[\[${CS_CYA}\]\u\[${CS_RST}\]@\[${CS_GRN}\]\h \[${CS_YEL}\]\w\[${CS_RST}\]]$ "
 
 hash figlet cowsay lolcat 2>/dev/null && figlet 'Oh Hi!' | cowsay -n | lolcat
