export SYSTEMD_EDITOR=vim
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

alias ls="ls -ahvlG --color"
alias open="xdg-open"
alias sys="sudo systemctl"
alias journal="sudo journalctl -fu"
alias dmesg="sudo dmesg"
alias apt="sudo apt"
alias pacman="sudo pacman"
alias service-status="sudo systemctl list-units --type=service --state=loaded --no-pager"
alias ufw="sudo ufw"
