# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
EDITOR=nvim

if [ "$(tty)" = "/dev/tty1" ]; then
  GDK_BACKEND=wayland
  CLUTTER_BACKEND=wayland
  QT_QPA_PLATFORM=wayland-egl
  QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  ECORE_EVAS_ENGINE=wayland_egl
  ELM_ENGINE=wayland_egl
  SDL_VIDEODRIVER=wayland
fi
