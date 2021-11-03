# set default CLI commands
abbr -a ping 'prettyping --nolegend'
abbr -a ls exa
abbr -a vim nvim
abbr -a find fd
abbr -a du dust
abbr -a ps procs
abbr -a cd z
abbr -a curl xh
abbr -a wget xh

# shortcuts
abbr -a l 'exa -F'
abbr -a ll 'exa -alF'
abbr -a la 'exa -aF'
abbr -a e code  # VSCode default cmd
abbr -a v nvim
abbr -a m make
abbr -a g git
abbr -a vimdiff 'nvim -d'

# no prompt greeting for speed
set fish_greeting

# https://draculatheme.com/fish
set -l foreground f8f8f2
set -l selection  44475a
set -l comment    6272a4
set -l red    ff5555
set -l orange ffb86c
set -l yellow f4f99d
set -l green  50fa7b
set -l cyan   8be9fd
set -l pink   ff79c6
set -l purple bd93f9
set -g fish_color_autosuggestion $comment
set -g fish_color_command        $cyan
set -g fish_color_comment        $comment
set -g fish_color_end            $orange
set -g fish_color_error          $red
set -g fish_color_escape         $pink
set -g fish_color_normal         $foreground
set -g fish_color_operator       $green
set -g fish_color_param          $purple
set -g fish_color_quote          $yellow
set -g fish_color_redirection    $foreground
set -g fish_color_search_match   --background=$selection
set -g fish_color_selection      --background=$selection

# general env
setenv EDITOR nvim
setenv NAME "Lucas V. Schuermann"
setenv EMAIL "lucas@lvs.io"
setenv TZ "America/New_York"

# make less better
# X = leave content on-screen
# F = quit automatically if less than one screenfull
# R = raw terminal characters (fixes git diff)
#     see http://jugglingbits.wordpress.com/2010/03/24/a-better-less-playing-nice-with-git/
setenv LESS "-F -X -R"

# fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'

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

# brew
abbr -a oldbrew '/usr/local/bin/brew'  # pre apple silicon
set -x PATH '/opt/homebrew/bin' $PATH
setenv HOMEBREW_NO_ANALYTICS 1

# go
set -x GOPATH $HOME/.go
set -x PATH $GOPATH $PATH

# rust
set -x PATH $HOME/.cargo/bin $PATH
set -x DYLD_FALLBACK_LIBRARY_PATH '/opt/homebrew/lib' $DYLD_FALLBACK_LIBRARY_PATH
setenv RUSTFLAGS "-L/opt/homebrew/lib -L/opt/homebrew/opt/libpq/lib -C target-cpu=native"
setenv CARGO_INCREMENTAL 1

# c and cpp
set -x PATH '/opt/homebrew/opt/llvm/bin' $PATH

# zoxide (cd replacement)
zoxide init fish | source

# python (keep at bottom)
set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
pyenv init --path | source
