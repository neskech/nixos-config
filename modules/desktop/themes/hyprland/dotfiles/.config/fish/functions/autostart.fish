function autostart
    # --- Core Desktop Components ---
    # Starts the plugin engine for scratchpads (drop-down term/volume) and extra window features
    pypr & 
    # Starts the wallpaper engine (sets the background image)
    hyprpaper & 
    # Starts the status bar at the top of the screen
    waybar & 

    # --- Clipboard Manager ---
    # Watches for copied text and saves it to history (accessible via SUPER+V)
    wl-paste --type text --watch cliphist store & 
    # Watches for copied images and saves them to history
    wl-paste --type image --watch cliphist store & 
    # Prevents the clipboard from clearing when you close the app you copied from
    wl-clip-persist --clipboard regular & 

    # --- System Utilities ---
    # Starts the On-Screen Display service (shows bubbles when changing volume/brightness)
    avizo-service & 
    # Starts the blue-light filter (like Night Shift) and adds an icon to the system tray
    gammastep-indicator &
    # Monitors system pressure (CPU/RAM/Disk strain) and notifies before a freeze occurs
    systemctl --user start psi-notify
end