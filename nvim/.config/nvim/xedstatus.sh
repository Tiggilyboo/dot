#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"
i3status -c "$DIR/wm/i3status.config" 
