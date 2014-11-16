#!/bin/bash

SYSTEMS="agentsmith"

for sys in $SYSTEMS
do
    echo "Copying vimrc to $sys"
    scp -r /Users/mdaue/.vim $sys:/home/tool
    scp /Users/mdaue/.vimrc $sys:/home/tool
done

SYSTEMS="desk adt1"
for sys in $SYSTEMS
do
    echo "Copying vimrc to $sys"
    scp -r /Users/mdaue/.vim $sys:/home/ddos
    scp /Users/mdaue/.vimrc $sys:/home/ddos
done

