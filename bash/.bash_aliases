# Set terminal tab title
settab() {
  echo -ne "\033]0;$1\007"
}

alias cls='clear'
alias reload='source ~/.bashrc'

alias v='nvim'
 
alias ll='ls -lah'
alias gs='git status'

