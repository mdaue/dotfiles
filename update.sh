#!/bin/bash

# Installs the git files by rsynching them... call this after updating your repo
# copy git
rsync -azP git/.gitconfig $HOME/
rsync -azP git/.gitignore $HOME/

# copy vim
rsync -azP vim/.vimrc $HOME/
rsync -azP vim/.vim $HOME/
rsync -azP vim/.gvimrc $HOME/

# copy fish
if [ ! -d "$HOME/.config/fish" ]
then
    mkdir -p "$HOME/.config/fish"
fi
rsync -azP fish/config.fish $HOME/.config/fish/
rsync -azP fish/functions $HOME/.config/fish/
rsync -azP fish/fishd "$HOME/.config/fish/fishd.`hostname`"

# copy i3
rsync -azP i3/.i3 $HOME/
