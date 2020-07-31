function fish_prompt
    set -l last_pipestatus $pipestatus
    
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    
    set_color yellow
    echo -n (basename $PWD)
    
    set_color green
    printf '%s ' (__fish_git_prompt)
    
    set -l pipestatus_string (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
    echo -n $pipestatus_string
    
    set_color red
    echo -n '~ '
    
    set_color normal
end