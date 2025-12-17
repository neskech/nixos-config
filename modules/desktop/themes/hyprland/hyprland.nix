{ pkgs, ... }:

{
  # --- 1. Hyprland Configuration ---
  programs.hyprland = {
    # Enables the Hyprland window manager.
    enable = true;
    
    # RECOMMENDED: Launches Hyprland using 'UWSM' (Universal Wayland Session Manager).
    # This wraps Hyprland in a systemd session, ensuring that background services
    # (like your wallpaper or bar) stop cleanly when you log out.
    withUWSM = true;
  };

  # --- 2. Nvidia & Wayland Compatibility ---
  
  # Hints Electron apps (like Discord, VS Code, and Obsidian) to use Wayland
  # instead of X11. This prevents blurry text and improves performance.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Required for proper window manager interaction with Java applications
  # Necessary for JetBrains IDEs and Minecraft
  environment.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";

  # CRITICAL FOR NVIDIA: On some Nvidia cards, the hardware cursor flickers or 
  # disappears. This forces the system to draw the cursor with software instead.
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # --- 3. Desktop Security & Power ---

  # Enables the screen locker utility.
  programs.hyprlock.enable = true;

  # Enables the idle daemon, which can be configured to dim the screen,
  # lock the session, or turn off monitors after a certain period of inactivity.
  services.hypridle.enable = true;

  # --- 4. The Hypr-Ecosystem (Utilities) ---
  # These are the "building blocks" of a functional Hyprland desktop.
  environment.systemPackages = with pkgs; [
    pyprland         # A plugin manager for extra features (like 'scratchpad' windows).
    hyprpicker       # A high-performance color picker tool for Wayland.
    hyprcursor       # A modern cursor format that supports high-resolution scaling.
    hyprlock         # The actual screen locker binary.
    hypridle         # The idle management binary.
    hyprpaper        # The official, fast wallpaper utility.
    hyprsunset       # A blue-light filter (Night Light) for late-night usage.
    wlr-randr        # Mandatory for managing monitors on Hyprland
    
    # CRITICAL: The "Polkit Agent." This is what creates the popup window 
    # when an app (like a software installer) asks for your password.
    hyprpolkitagent  
  ];
}