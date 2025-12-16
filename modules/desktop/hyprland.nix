# Hyprland Configuration
# A dynamic tiling wayland compositor with extensive customization
{ config, pkgs, ... }:

{
  # Import wayland environment settings
  imports = [ ./wayland.nix ];

  # Enable and configure Hyprland compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Required for Steam and game compatibility
  };

  # Essential packages for Hyprland desktop environment
  environment.systemPackages = with pkgs; [
    # Core desktop utilities
    kitty             # Default terminal emulator for Hyprland
    waybar            # Customizable status bar
    swww              # Wallpaper daemon for wayland
    dunst             # Notification daemon
    rofi              # Application launcher and menu system
    
    # Screenshot and clipboard management
    grim              # Screenshot utility for wayland
    slurp             # Interactive region selector for screenshots
    wl-clipboard      # Wayland clipboard manager
  ];
  
  # Configure XDG portal for screen sharing and portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # GTK portal for wayland
  };
}
