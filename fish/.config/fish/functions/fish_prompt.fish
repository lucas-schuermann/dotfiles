# simple prompt with time, path, git status, and separator
function fish_prompt
    set -l last_pipestatus $pipestatus
    
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    
    # show @hostname only if in a remote session
    set_color yellow
    if set --query SSH_CLIENT
        echo -n (basename $PWD)@(hostname)
    else
        echo -n (basename $PWD)
    end
    
    set_color green
    printf '%s ' (__fish_git_prompt)
    
    set -l pipestatus_string (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
    echo -n $pipestatus_string
    
    set_color red
    echo -n '~ '
    
    set_color normal
end
