{ pkgs, ... }:

{
  # --- 1. SYSTEM SERVICES & DAEMONS ---

  # Settings Database: Low-level storage for GTK/Gnome app preferences
  programs.dconf.enable = true;

  # Message Bus: The "nervous system" allowing apps to talk to each other
  services.dbus = {
    enable = true;
    implementation = "broker"; # High-performance replacement for traditional D-Bus
    packages = with pkgs; [
      xfce.xfconf   # Settings engine for XFCE apps (like Thunar)
      gnome2.GConf  # Legacy settings engine for older applications
    ];
  };

  # Allows chrome to start up because it wants to query battery level
  services.upower.enable = true;

  # File Manager Backend: Stores settings for Thunar
  programs.xfconf.enable = true;

  # File Manager: High-speed, lightweight file explorer
  programs.thunar.enable = true;

  # Thumbnailer: Required to see image/video previews in Thunar
  services.tumbler.enable = true; 

  # --- 2. USER ENVIRONMENT & APPLICATIONS ---

  environment.systemPackages = with pkgs; [
    # -- Browsers & Viewers --
    # qutebrowser      # Keyboard-driven, Vim-like web browser
    zathura          # Minimalist document viewer (PDF, DJVU)
    mpv              # High-performance video player
  #  mpv-handler      # Opens web-video links (YT) directly in MPV
    imv              # Blazing fast image viewer for Wayland

    # -- Core Wayland/Hyprland Tools --
    waybar           # Customizable status bar
    rofi              # App launcher and search menu
    dunst            # Notification daemon (pop-up alerts)
    wlogout          # Graphical menu for logout/shutdown/reboot
    
    # -- Screenshots & Media Creation --
    grim             # Screen capture tool (the "shutter")
    slurp            # Region selector (the "crosshair" for grim)
    swappy           # Screenshot editor (adds arrows, text, blurs)
    wl-screenrec     # High-efficiency screen recorder

    # -- Clipboard & Input --
    wl-clipboard     # Copy/paste utilities for the terminal
    wl-clip-persist  # Keeps clipboard data alive after an app closes
    cliphist         # Clipboard history manager (search old copies)
    wlrctl           # CLI utility for Wayland state/input control
    
    # -- System Monitoring & Integration --
    qt6.qtwayland    # Forces Qt6 apps to run natively on Wayland
    psi-notify       # Alerts you when RAM/CPU pressure is too high

    # --- 4. The Hypr-Ecosystem (Utilities) ---
    # These are the "building blocks" of a functional Hyprland desktop.
    pyprland         # A plugin manager for extra features (like 'scratchpad' windows).
    hyprpicker       # A high-performance color picker tool for Wayland.
    hyprcursor       # A modern cursor format that supports high-resolution scaling.
    hyprlock         # The actual screen locker binary.
    hypridle         # The idle management binary.
    hyprpaper        # The official, fast wallpaper utility.
    hyprsunset       # A blue-light filter (Night Light) for late-night usage.
    wlr-randr        # Mandatory for managing monitors on Hyprland
    
    # Icon pack for rofi
    numix-icon-theme-circle
    
    # CRITICAL: The "Polkit Agent." This is what creates the popup window 
    # when an app (like a software installer) asks for your password.
    hyprpolkitagent  
  ];
}
