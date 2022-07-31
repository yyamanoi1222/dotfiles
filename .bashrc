export PATH=/usr/local:$PATH

# Ruby
if [ -x "`which rbenv`" ]; then
  eval "$(rbenv init -)"
fi

if [ -x "`which xdg-open`" ]; then
  alias open="xdg-open"
fi

if [ -x "`which pyenv`" ]; then
  eval "$(pyenv init -)"
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi


# Go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/google-cloud-sdk/bin

# Nvm
if [[ -s ~/.nvm/nvm.sh ]];
 then source ~/.nvm/nvm.sh
fi


# Rails
alias routes='bundle exec rake routes | grep'
alias migrate='bundle exec rake db:migrate'
alias rollback='bundle exec rake db:rollback'
alias console='bin/rails console'
alias rake='bundle exec rake'
alias rspec='bundle exec rspec'
alias clearcache='bin/rails r "Rails.cache.clear"'
alias webpacker="bin/webpack-dev-server"

alias ll='ls -la'


# Git
alias gc='git checkout'
alias gcp='git checkout $(git branch -a --sort=-authordate | cut -b 3- | grep -v -- "->" | peco | sed -e "s%remotes/origin/%%")'
alias gcb='git checkout -b'
alias gb='git branch'
alias gbn='git branch --no-merged'
alias gbc='git symbolic-ref --short HEAD'
alias gd='git diff'
alias gs='git status'
alias gl='git log --graph --oneline --decorate=full --date=short --format="%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)"'
alias gsh='git show'
alias gri='git rebase -i'

alias ff='find ./ -type f -print | xargs grep'

alias vi='vim'

alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
