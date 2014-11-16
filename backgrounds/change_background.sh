#!/bin/bash

WALLPAPER_REPO="$HOME/wallpaper/"
LOGGED_IN=$(who | grep ':0\s' | awk '{print $1;}')

wallpaper=( "$WALLPAPER_REPO"/* )

RAND_INDEX=$[ 1 + $[ RANDOM % ${#wallpaper[@]} ]]

feh --bg-scale ${wallpaper[$RAND_INDEX]}
