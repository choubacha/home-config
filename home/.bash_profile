[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if [ -f $HOME/.bashrc ]
then
  . $HOME/.bashrc
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

complete -C aws_completer aws

# ALIASES
alias dockerclear='docker rm $(docker ps -aq --filter="status=exited") && docker rmi $(docker images -q --filter="dangling=true")'

eval $(boot2docker shellinit) > /dev/null
export PS1="\[\033[1;32m\]\u\[\033[0;37m\]@\[\033[1;34m\]\h:\W\[\033[0;37m\]"
export PS1="$PS1\n$ "

cp-from-docker () {
  docker-compose run web cat $1 > $1
}

dc-web () {
  docker-compose run web "$@"
}

dc-test () {
  docker-compose run -e RAILS_ENV=test web "$@"
}

git-delete-local-branches () {
  git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
}
