#!/usr/bin/bash

waypaper --random

wallpaper=$(waypaper --list | jq -r '.[0].wallpaper')

wal -i $wallpaper

emacsclient -e '(my/apply-wal-colors-to-zen-theme)'
