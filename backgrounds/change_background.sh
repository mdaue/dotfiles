#!/bin/bash

WALLPAPER_REPO="$HOME/wallpaper/"

wallpaper=( "$WALLPAPER_REPO"/* )

RAND_INDEX=$[ 1 + $[ RANDOM % ${#wallpaper[@]} ]]

feh --bg-scale ${wallpaper[$RAND_INDEX]}
