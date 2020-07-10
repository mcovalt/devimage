set fish_color_command green
set fish_color_quote yellow
set fish_color_redirection normal
set fish_color_end normal
set fish_color_error --bold red
set fish_color_param normal
set fish_color_operator --bold blue
set fish_color_comment brblack
set fish_color_match --bold green
set fish_color_autosuggestion brblack
set fish_color_escape --background=brred normal
set fish_pager_color_description purple
set fish_pager_color_progress black --background=cyan

set fish_greeting ""



alias ls="exa"
alias grep="rg -uuu"
alias bat="batcat"
set -x MANPAGER "sh -c 'col -bx | batcat -l man -p'"

starship init fish | source
