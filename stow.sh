#!/bin/bash

for d in *; do
  if [[ -d $d ]]; then
    stow -t ~/ $d
    echo "Stowing ${d}..."
  fi
done
