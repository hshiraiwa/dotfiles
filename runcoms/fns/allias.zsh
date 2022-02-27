alias repos="cd ~/Documents/Repos"
alias personal="cd ~/Documents/Personal"
alias dotfiles="cd ~/.dotfiles"
if command -v xdg-open &>/dev/null; then
    alias open="xdg-open"
elif ! command -v open &>/dev/null; then
    alias open="powershell.exe start"
fi

if command -v nvim &>/dev/null; then
    alias vim=nvim
fi
