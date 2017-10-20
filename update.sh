#!/bin/bash

if [[ -f /usr/bin/apt-get ]]; then
    OS="deb"
elif [[ -f /usr/bin/yum || -f /usr/bin/dnf ]]; then
    OS="rpm"
elif [[ -f /sbin/apk ]]; then
    OS="apk"
else
    echo "Error determining package manager"
    OS="UNKNOWN"
fi

# Installs the git files by rsynching them... call this after updating your repo
# copy git
rsync -azP git/.gitconfig $HOME/
rsync -azP git/.gitignore $HOME/

# copy .gdbinit
rsync -azP gdb/.gdbinit $HOME/

mkdir -p $HOME/bin
rsync -azP bin/ $HOME/bin/

# copy tmux
rsync -azP tmux/.tmux.conf $HOME/

# copy vim
rsync -azP vim/.vimrc $HOME/
# Start VIM plugin install
vim +PluginInstall +qall

# copy nvim
rsync -azP nvim/.config $HOME/

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
sudo cp i3/i3lock.service /etc/systemd/system/
sudo systemctl enable i3lock.service

# copy zsh stuff
rsync -azP zsh/oh-my-zsh $HOME/
mkdir $HOME/.oh-my-zsh
mv $HOME/oh-my-zsh/* $HOME/.oh-my-zsh
rsync -azP zsh/.zshrc $HOME/.zshrc

# copy systemd scripts
rsync -azP systemd $HOME/.config/

# copy screenlayouts
rsync -azP screenlayout/.screenlayout $HOME/

if [[ -z ~/.fzf ]]; then
    pushd $HOME
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    popd
fi

# Run installer everytime since the zsh file is overwritten
~/.fzf/install --all

# Install git
if [[ -z /usr/bin/git ]]; then
    if [[ "$OS" == "deb" ]]; then sudo apt-get install -y git; fi
    if [[ "$OS" == "rpm" ]]; then sudo yum install -y git; fi
fi

# Install AG
if [[ "$OS" == "deb" ]]; then sudo apt-get install -y silversearcher-ag; fi
if [[ "$OS" == "rpm" ]]; then
    sudo yum install -y pcre-devel xz-devel
    pushd /usr/local/src
    sudo git clone https://github.com/ggreer/the_silver_searcher.git
    cd the_silver_searcher
    sudo ./build.sh
    sudo make install
    popd
fi

# Install tmux plugin manager
if [[ ! -f ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

