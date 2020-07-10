# devimage:base
A Docker image I use to develop in.

Contains:
- [bat](https://github.com/sharkdp/bat)
- curl
- [curlie](https://curlie.io/)
- [exa](https://github.com/ogham/exa) (aliased to `ls`)
- [fd](https://github.com/sharkdp/fd)
- [fish](https://fishshell.com/) (default shell)
- git
- gnupg
- htop
- jq
- less
- [ripgrep](https://github.com/BurntSushi/ripgrep) (aliased to `grep`)
- [s6](https://github.com/just-containers/s6-overlay) (includes init stript to try to set `localtime` based on IP)
- ssh client
- [starship](https://starship.rs/) made to look somewhat like [pure](https://github.com/sindresorhus/pure)
- tmux
- tzdata
- vim

Vim, tmux, and fish have been configured to only use ANSI colors so it's hopefully easier to style and color.
