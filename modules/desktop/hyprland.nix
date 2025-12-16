{ config, pkgs, ... }:

{

  imports = [ ./wayland.nix ];

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Essential for Steam/games
  };

  # Optional: Hint Electron apps to use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Essential Hyprland Packages
  environment.systemPackages = with pkgs; [
    # The Basics
    kitty             # A good terminal (Default for Hyprland)
    waybar            # The status bar
    swww              # Wallpaper daemon
    dunst             # Notification daemon
    rofi      # App launcher (better than wofi for Hyprland usually)
    
    # Screenshots / Clipboard
    grim              # Screenshot tool
    slurp             # Select area for screenshot
    wl-clipboard      # Clipboard manager
  ];
  
  # Configure xdg-portal (essential for screen sharing to work)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
