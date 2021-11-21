#!/bin/bash

OH_MY_ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${OH_MY_ZSH}/custom"

function update
{
    if [[ -z "$1" ]]; then
        return
    fi
    if [[ -f /usr/bin/git ]]; then
        echo "Updating repository in $1"
        pushd $1
        git pull origin master --quiet
        git submodule update --recursive --quiet
        popd
    fi
}

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

if [[ $OSTYPE == "linux-gnu"* ]]; then
    OS_SPECIFIC_SUBDIR="linux"
elif [[ $OSTYPE == "darwin"* ]]; then
    OS_SPECIFIC_SUBDIR="macos"
else
    echo "Unable to determine operating system (checked either for linux or mac)"
    OS_SPECIFIC_SUBDIR=""
fi

if [[ $OSTYPE == "darwin"* ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
rsync -azP tmux/$OS_SPECIFIC_SUBDIR/.tmux.conf $HOME/

if [[ $OSTYPE == "darwin"* ]]; then
    brew install vim
    brew link vim
fi

if [[ $OSTYPE == "linux-gnu"* ]]; then
    echo "Install pyenv manually"
elif [[ $OSTYPE == "darwin"* ]]; then
    brew install pyenv
    CONFIGURE_OPTS=--enabled-shared pyenv install 3.9.1
    pyenv global 3.9.1
else
    echo "Dunno OS"
fi

# copy vim
rsync -azP vim/.vimrc $HOME/
# Start VIM plugin install
vim +PluginInstall +qall

# copy fish
if [ ! -d "$HOME/.config/fish" ]
then
    mkdir -p "$HOME/.config/fish"
fi

# Install virtualfish
PIP2=$(which pip2)
PIP3=$(which pip3)

if [ -z ${PIP2+x} ]; then pip2 install --upgrade virtualfish thefuck; fi
if [ -z ${PIP3+x} ]; then pip3 install --upgrade virtualfish thefuck; fi

echo "If using FISH, see http://virtualfish.readthedocs.io/en/latest/install.html#customizing-your-fish-prompt to customize your FISH prompt for virtualenvwrapper"

rsync -azP fish/config.fish $HOME/.config/fish/
rsync -azP fish/functions $HOME/.config/fish/
rsync -azP fish/fishd "$HOME/.config/fish/fishd.`hostname`"

# copy i3
if [[ $OSTYPE == "linux-gnu"* ]]; then
    rsync -azP i3/.i3 $HOME/
    sudo cp i3/i3lock.service /etc/systemd/system/
    sudo systemctl enable i3lock.service
fi

# copy zsh stuff
if [[ ! -d $HOME/.oh-my-zsh ]]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
else
    update $HOME/.oh-my-zsh
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt"
ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${OH_MY_ZSH}/themes/spaceship.zsh-theme"
mkdir -p ~/.oh-my-zsh/plugins/bazel
wget -P ~/.oh-my-zsh/plugins https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel

rsync -azP zsh/$OS_SPECIFIC_SUBDIR/.zshrc $HOME/.zshrc

# copy systemd scripts
if [[ $OSTYPE == "linux-gnu"* ]]; then
    rsync -azP systemd $HOME/.config/
fi

# copy screenlayouts
if [[ $OSTYPE == "linux-gnu"* ]]; then
    rsync -azP screenlayout/.screenlayout $HOME/
fi

if [[ ! -d ~/.fzf ]]; then
    pushd $HOME
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    popd
else
    update $HOME/.fzf
fi

# Run installer everytime since the zsh file is overwritten
~/.fzf/install --all

# Install git
if [[ ! -f /usr/bin/git ]]; then
    if [[ "$OS" == "deb" ]]; then sudo apt-get install -y git; fi
    if [[ "$OS" == "rpm" ]]; then sudo yum install -y git; fi
    if [[ $OSTYPE == "darwin"* ]]; then
        brew install git
    fi
fi

# Install AG
if [[ "$OS" == "deb" ]]; then sudo apt-get install -y silversearcher-ag; fi
if [[ "$OS" == "rpm" ]]; then
    sudo yum install -y pcre-devel xz-devel
    pushd /usr/local/src
    if [[ ! -d /usr/local/src/the_silver_searcher ]]; then
        sudo git clone https://github.com/ggreer/the_silver_searcher.git
    else
        update /usr/local/src/the_silver_searcher
    fi
    cd the_silver_searcher
    sudo ./build.sh
    sudo make install
    popd
fi

# Install tmux plugin manager
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
    update $HOME/.tmux/plugins/tpm
fi

if [[ $OSTYPE == "darwin"* ]]; then
    brew install alacritty
    cp -r alacritty ~/.config/
fi

# Install Pyenv
if [[ -f /usr/bin/git ]]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    cd ~/.pyenv && src/configure && make -C src

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
    echo 'eval "$(pyenv init --path)"' >> ~/.zprofile

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
    echo 'eval "$(pyenv init --path)"' >> ~/.profile

    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi
