FROM tiggilyboo/qmk
MAINTAINER Simon Willshire <me@simonwillshire.com>
LABEL description="Custom Planck Keymap"

ENV KEYBOARD=planck \
    REVISION=rev5 \
    KEYMAP=tiggilyboo \
    TARGET=dfu 

VOLUME /src/keyboards/planck/keymaps
ENTRYPOINT make $KEYBOARD/$REVISION:$KEYMAP:$TARGET
CMD /bin/bash 
