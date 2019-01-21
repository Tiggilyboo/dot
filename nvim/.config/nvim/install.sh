#!/bin/bash
printf 'Updating...'
sudo apr-get update
printf 'Installing xed...'

sudo ln -s $PWD/xed.sh /usr/bin/xed
sudo ln -s $PWD/xedwm.sh /usr/bin/xedwm
sudo ln -s $PWD/xedstatus.sh /usr/bin/xedstatus
sudo ln -s /usr/bin/thunar /usr/bin/xfv
sudo ln -s /usr/bin/samus-alsaenable-headphones /usr/bin/xahp
sudo ln -s /usr/bin/samus-alsaenable-speakers /usr/bin/xasp
sudo ln -s /opt/toggldesktop/TogglDesktop.sh /usr/bin/toggl

