# Hyprland Configuration
# A dynamic tiling wayland compositor with extensive customization
{ config, pkgs, ... }:

{
  # Import wayland environment settings
  imports = [ 
    ./wayland.nix
    ./hyprland-rices/dots-hyprland
 ];

  # Enable and configure Hyprland compositor

  programs.hyprland = {
    enable = true;
    # USE THE FLAKE VERSION
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland; 
    xwayland.enable = true; 
  };

  # Essential packages for Hyprland desktop environment
  environment.systemPackages = with pkgs; [
    # Core desktop utilities
    kitty             # Default terminal emulator for Hyprland
    waybar            # Customizable status bar
    # swww              # Wallpaper daemon for wayland
    dunst             # Notification daemon
    rofi              # Application launcher and menu system
    kdePackages.dolphin           # File manager
    
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
