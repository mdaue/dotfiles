#!/bin/bash

# Installs the git files by rsynching them... call this after updating your repo
# copy git
rsync -azP git/.gitconfig $HOME/
rsync -azP git/.gitignore $HOME/

mkdir -p $HOME/bin
rsync -azP bin/ $HOME/bin/

# copy vim
rsync -azP vim/.vimrc $HOME/
rsync -azP vim/.vim $HOME/
rsync -azP vim/.gvimrc $HOME/

# copy nvim
rsync -azP nvim/.config $HOME/
echo "alias vi=nvim" >> $HOME/.bashrc

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

# copy zsh stuff
rsync -azP zsh/oh-my-zsh $HOME/
mv $HOME/oh-my-zsh/* $HOME/.oh-my-zsh
rsync -azP zsh/.zshrc $HOME/.zshrc

# copy systemd scripts
rsync -azP systemd $HOME/.config/

# copy screenlayouts
rsync -azP screenlayout/.screenlayout $HOME/

# copy background updater
sudo cp backgrounds/change_background.sh /usr/bin/change_background.sh
