# xed

Preconfigured nvim for my daily dev work.

- No swap files, 
- in memory editing, 
- tabs are 2 spaces
- numbered lines
- files in buffers update if changed externally (useful for external gofmt invocations)
- onedark theme (looks like atom)
- file browser (netrw) actually looks nice, opens in previous buffer, in tree 

## Install
```sh
$ ./install.sh
```

## Workspaces
xed comes with some preconfigured workspaces. Workspaces just save a few key presses depending on the task you are doing.

### Dev
```sh
$ xed -c Dev somefile 
```
Opens a left split 22% wide showing the current directory in netrw, opens in the main right split. There is also a bottom split terminal opened to the invoked directory.

## Plugins
See xed.vim plugin section
