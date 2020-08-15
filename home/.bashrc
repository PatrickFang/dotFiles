##################### Colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"

##################### Add Git info to prompt
source ~/.git-prompt.sh
source ~/.git-completion.bash

minutes_since_last_commit() {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
        echo ${GIT_PROMPT}
    fi
}

PS1="$C_RED\h: $C_BLUE\w\$(git_prompt) \n$C_DEFAULT\$ "

##################### Aliases and helper functions

alias vfwd='cd ~/vagrant/ && vagrant ssh -- -N -L 3000:localhost:3000'
alias vssh='cd ~/vagrant/ && vagrant ssh'
alias ctagshere='ctags -R --exclude=.git --exclude=log --exclude=node_modules *'

alias bert='bundle exec rake test:all'
alias beri='RAILS_ENV=test bundle exec ruby -Itest'
alias gs='git ss'
alias ga='git aa'
alias gd='git diff'
alias gdc='git dc'
alias subl='sublime'


if [[ $OSTYPE = darwin* ]]; then
  alias ll='ls -alFG'
  alias la='ls -ACG'
  alias ls='ls -CFG'
elif [ $OSTYPE == 'linux-gnu' ]; then
  alias ll='ls --color=auto -alF'
  alias la='ls --color=auto -ACF'
  alias ls='ls --color=auto -CF'
fi

alias g='grep -r'
export GREP_OPTIONS='--color=always -nI'

if [[ $OSTYPE = darwin* ]]; then
  update_vagrant() {
    cd ~/vagrant/ \
      && git pull origin master \
      && vagrant up \
      && vagrant provision
  }
fi

kill_unicorns() {
  kill -9 $(ps aux | grep unicorn | awk "{print $2}")
}

##################### Ssh-agent launch

source ~/.git-ssh-agent-launch.sh

##################### Tmux Options

source ~/.tmuxinator/tmuxinator.bash

##################### History options

export CLICOLOR=1
HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=10000 # Store 10k history entries
export HISTTIMEFORMAT="%d/%m/%y %T "

##################### MISC options

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
export EDITOR='vim'

##################### Bash completion options

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [[ $OSTYPE = darwin* ]]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

##################### PATH options

export PATH="/usr/local/heroku/bin:$PATH"
export PATH=/usr/local/bin:$PATH

if [ $OSTYPE == 'linux-gnu' ]; then
  export PATH=$HOME/npm/bin:$PATH
fi


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.yarn/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


