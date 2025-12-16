# Niri Window Manager Configuration
# Configuration for the Niri wayland window manager
{ config, pkgs, ... }:

{
  # Import wayland environment settings
  imports = [
    ./wayland.nix
  ];
  
  # Enable Niri window manager
  programs.niri.enable = true;

  # Packages required for Niri desktop environment
  environment.systemPackages = with pkgs; [
    alacritty   # GPU-accelerated terminal emulator
    fuzzel      # Application launcher for wayland
    waybar      # Status bar for Niri
  ];
}
