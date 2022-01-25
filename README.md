dotfiles
========

All ze Dotfiles

# VIM
Has a set of VIM plugins mostly for ease of developing in a variety of languages (Python, Go, C, Dart, Javascript)

YouCompleteMe has to be compiled before use (cd into it's dir, git submodule update --init --recursive; ./install.sh --clang-completer)

VIM will need to be compiled with Python3 support; https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source has the instructions.

# ZSH
Uses .zprezto, the setup script should automagically set everything up

# Fish
An alternate shell (Friendly Interactive SHell)

# i3
The only window manager...

Recommend getting the droid font for the font to look right

# Git
Useful Git hooks

# NVIDIA
On Linux systems, the NVIDIA CUDA driver will break suspend (still as of Ubuntu 21.10, nvidia-driver-510); to fix it, there is a fixit.sh script in the nvidia folder that installs systemd files to use the nvidia suspend scripts.

# Backgrounds
A script that can be dropped into your cron.hourly to change the screen background every hour. Must have the jpgs that should be display in $HOME/wallpaper
