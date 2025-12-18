function screenshot_to_clipboard
    # 1. Get the selection first (so if you cancel, it stops here)
    set geometry (slurp)
    if test -z "$geometry"
        return 1 # Stop if you pressed Escape
    end

    # 2. Set the filename
    set screenshot_filename "$HOME/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d--%H-%M-%S').png"

    # 3. The Magic Line:
    # - captures screenshot (grim)
    # - sends it to the file (tee)
    # - AND sends it to clipboard (wl-copy) all at once
    grim -g "$geometry" - | tee "$screenshot_filename" | wl-copy

    # 4. Notify
    dunstify -i "$screenshot_filename" "Screenshot Taken" "Saved to folder" -t 2000
end