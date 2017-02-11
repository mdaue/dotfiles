# Thunar / XDG-MIME
xdg-mime can be used to set default variables in desktop user environments
This example installs and sets as default the thunar file manager. This is because i3 and nautilus don't seem to get along

## Install thunar
sudo apt-get install thunar

## Set thunar as default
xdg-mime default Thunar.desktop inode/directory
