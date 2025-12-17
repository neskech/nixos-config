{ config, pkgs, ... }:

{
  home-manager.users.ness = { pkgs, ... }: {

    # ============================================================================
    # HYPRLAND FILE SYMLINKS
    # ============================================================================
    
    # 1. Symlink the Folders
    # This maps ~/nixos-config/hypr-rice/hyprland -> ~/.config/hypr/hyprland
    xdg.configFile."hypr/hyprland".source = ./hyprland;
    xdg.configFile."hypr/custom".source   = ./custom;

    # 2. Symlink the Standalone Files
    # This maps ~/nixos-config/hypr-rice/monitors.conf -> ~/.config/hypr/monitors.conf
    # WARNING: These will be READ-ONLY. If you use a tool like 'nwg-displays' to 
    # change your resolution, it will crash. You must edit monitors.conf manually 
    # in your nixos-config folder instead.
    xdg.configFile."hypr/workspaces.conf".source = ./workspaces.conf;
    xdg.configFile."hypr/monitors.conf".source   = ./monitors.conf;

    # ============================================================================
    # HYPRLAND MODULE
    # ============================================================================


    wayland.windowManager.hyprland = {
      enable = true;
      
      # 1. TELL HOME MANAGER TO USE THE FLAKE HYPRLAND
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;

      # 2. INSTALL THE PLUGINS (Hyprbars & HyprExpo)
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      ];

      # Keep your existing config read
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    # (Optional) Ensure Hyprland dependencies are installed
    # Since you are managing the config manually now, make sure you have the tools
    # referenced in 'execs.conf' installed!
    home.packages = with pkgs; [
    # --- ESSENTIALS ---
      inputs.quickshell.packages.${pkgs.system}.default
      hyprpaper       # Simple wallpaper engine
      swww            # Complex wallpaper engine (Likely used by the scripts in your rice)
      hyprlock        # Lock screen
      wlogout         # Power menu (Logout/Shutdown/Reboot) referenced in binds
      
      # --- LAUNCHERS ---
      fuzzel          # The launcher the CONFIG wants to use (Install this so the fallback binds work)

      # --- STATUS BAR ---
      waybar          # The bar

      # --- SCREENSHOTS & RECORDING ---
      grim            # Takes the screenshot
      slurp           # Selects the region
      hyprpicker      # Color picker (Super+Shift+C)
      tesseract       # OCR (Grabs text from images - Super+Shift+X)
      imagemagick     # Image manipulation (needed for some screenshot scripts)

      # --- CLIPBOARD ---
      wl-clipboard    # The main clipboard tool
      cliphist        # Clipboard history manager (Super+V)

      # --- MEDIA & HARDWARE ---
      playerctl       # Makes media keys work (Play/Pause/Next)
      brightnessctl   # Makes brightness keys work
      pavucontrol     # Volume Mixer GUI (referenced in binds)
      libnotify       # Allows 'notify-send' to work (Popups)
      
      # --- FILE MANAGERS ---
      kdePackages.dolphin # File Manager
      
    ];
  };
}