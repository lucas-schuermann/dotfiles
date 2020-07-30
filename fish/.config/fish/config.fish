abbr -a ping 'prettyping --nolegend'
abbr -a l 'exa -F'
abbr -a ls 'exa'
abbr -a ll 'exa -alF'
abbr -a la 'exa -aF'
abbr -a e nvim
abbr -a m make
abbr -a g git
abbr -a vimdiff 'nvim -d'
abbr -a vim 'nvim'

set fish_greeting

# fish_config Dracula
set -U fish_color_normal normal
set -U fish_color_command F8F8F2
set -U fish_color_quote F1FA8C
set -U fish_color_redirection 8BE9FD
set -U fish_color_end 50FA7B
set -U fish_color_error FFB86C
set -U fish_color_param FF79C6
set -U fish_color_comment 6272A4
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion BD93F9
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

# general env
setenv EDITOR nvim
setenv NAME "Lucas V. Schuermann"
setenv EMAIL "lucas.v.schuermann@gmail.com"
setenv TZ "America/New_York"

# make less better
# X = leave content on-screen
# F = quit automatically if less than one screenfull
# R = raw terminal characters (fixes git diff)
#     see http://jugglingbits.wordpress.com/2010/03/24/a-better-less-playing-nice-with-git/
setenv LESS "-F -X -R"

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

# fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set -g fish_prompt_pwd_dir_length 3

# use ripgrep for fzf
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# rust
set -x PATH $HOME/.cargo/bin $PATH
setenv CARGO_INCREMENTAL 1
setenv RUST_BACKTRACE 1
setenv RUSTFLAGS "-C target-cpu=native"

# python (keep at bottom)
set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
# `pyenv init - | source` is slow, copied below without `pyenv rehash` (do manually)
# and `function pyenv` (only for `pyenv shell`)
set -gx PATH '/Users/Lucas/.pyenv/shims' $PATH
set -gx PYENV_SHELL fish
source '/usr/local/Cellar/pyenv/1.2.20/libexec/../completions/pyenv.fish'
