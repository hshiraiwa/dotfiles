#!/bin/zsh

cat ~/.dotfiles/configs/vscode/extensions | xargs -n 1 code --install-extension
cp -f ~/.dotfiles/configs/vscode/keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
cp -f ~/.dotfiles/configs/vscode/settings.json ~/.config/Code\ -\ OSS/User/settings.json
