# ##########################################################################
# EXPORT
# ##########################################################################

# Show color
export CLICOLOR=1

# Use neo-vim as default text editor
export EDITOR='nvim'

# Add home dir scripts to the path
export PATH=~/bin:$PATH

# Show password prompt in terminal for GPG
export GPG_TTY=$(tty)

# ##########################################################################
# ALIAS
# ##########################################################################

alias df='df -h'
alias dus='du -hs'
alias l='ls -CF'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls -h'
alias lt='ls -ltr'
alias vim='nvim'
alias vi=vim

# Ruby
alias be='bundle exec'
alias rspec='rspec --color'

# Git
alias g='git s'
alias gap='git ap'
alias gd='git d'
alias gds='git ds'
alias gl='git l'
alias gs='git s'
alias gaa='git aa'
alias gc='git c'
alias gcm='git commit -m'

# ##########################################################################
# CONFIG
# ##########################################################################

# Disable auto-correct
unsetopt correct_all

# Show pure prompt
fpath+=('/usr/local/lib/node_modules/pure-prompt/functions')
autoload -U promptinit; promptinit
prompt pure

# Key bindings, for all options see docs:
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '^l' clear-screen
bindkey -v

# ##########################################################################
# EXE
# ##########################################################################

# Start up SSH Agent to avoid constant password prompts
eval $(ssh-agent) &>/dev/null

# Load up correct ruby version
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Always work in a tmux session if tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi
