#!/bin/sh
# Command to add bookmark into my personal wiki
FAV_FILE=~/wres/pro/bookmark.wiki
echo $1 >> $FAV_FILE && urxvt -e vim $FAV_FILE +
