# Structure

<pre>
├── install.sh <---------- set everything up
|
├── profile
├── xprofile
|
├── <b>bash</b> <---------- bash-specific stuff
│   ├── alias
│   ├── env
│   ├── prompt
│   └── bashrc
│
├── <b>git</b>
│   ├── config
│   ├── ignore
│   └── message
│
├── <b>i3</b>
│   └── config
│
├── <b>python</b>
│   └── pythonrc
│
├── <b>shell</b> <---------- shell-independent stuff
│   ├── alias
│   ├── env
│   └── function
│
├── <b>tmux</b>
│   └── tmux.conf
│
├── <b>vim</b>
│   ├── bind.vim
│   ├── function.vim
│   └── vimrc
│
├── <b>wsl</b> <---------- wsl-specific stuff
│   └── env
│
└── <b>zsh</b> <---------- zsh-specific stuff
    ├── alias
    ├── env
    ├── function
    ├── prompt
    └── zshrc
</pre>

### shell/env

```sh
XDG_CACHE_HOME  - user-specific non-essential (cached) data.
XDG_CONFIG_HOME - user-specific configuration files.
XDG_DATA_HOME   - user-specific data files.

EDITOR - default system editor.
```
### wsl/env

```sh
WINHOME - windows home directory
WINDESK - windows desktop directory
```
