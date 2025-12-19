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

  # This replaces "google-chrome" system-wide with your modified version
  # Forces chrome and vscode to use wayland to prevent graphical bugs
  nixpkgs.overlays = [
    (self: super: {
      # 1. Google Chrome Override
      google-chrome = super.google-chrome.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --use-angle=gl --gtk-version=4";
      };

      # 2. VS Code Override
      vscode = super.vscode.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
    })
  ];


  # Enables the screen locker utility.
  programs.hyprlock.enable = true;

  # Enables the idle daemon, which can be configured to dim the screen,
  # lock the session, or turn off monitors after a certain period of inactivity.
  services.hypridle.enable = true;

  # Allows screen sharing and other stuff
  xdg.portal = {
    enable = true; # Activates the portal system
    
    # The GTK portal provides the 'File Picker' (Open/Save window) 
    # since Hyprland doesn't have a built-in one
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
    
    # Tells the system to use these portals for all standard requests
    config.common.default = "*"; 
  };
}
