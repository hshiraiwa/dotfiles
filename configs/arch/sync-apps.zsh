#!/bin/zsh

if command -v pamac &>/dev/null; then
    pamac update --no-confirm
    pamac upgrade --no-confirm

    pamac remove --no-confirm $(cat $HOME/.dotfiles/configs/arch/application-remove)
    pamac install --no-confirm $(cat $HOME/.dotfiles/configs/arch/application-install)
fi
