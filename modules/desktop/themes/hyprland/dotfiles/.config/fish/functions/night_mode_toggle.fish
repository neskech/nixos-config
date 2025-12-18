function night_mode_toggle
    set target_process hyprsunset
    set temp_file ~/.cache/hyprsunset_temp

    # 1. Forceful Check and Kill
    if pgrep -x $target_process >/dev/null
        # Use pkill for a more direct hit than killall
        pkill -x $target_process
        
        # Short 'wait' to ensure the process is actually gone before the next potential click
        while pgrep -x $target_process >/dev/null
            sleep 0.1
        end
    else
        # 2. Logic for Starting
        if test -f $temp_file
            set temp (cat $temp_file)
        else
            set temp 4000
            echo $temp > $temp_file
        end
        
        # Start in the background so it doesn't block Waybar
        $target_process -t $temp & 
    end
end