# Desktop Environment Configuration
# Imports desktop manager and window manager configurations
{ config, pkgs, ... }:

{
  # Import desktop environment modules
  imports = [
    ./hyprland.nix  # Hyprland wayland compositor
    ./x11.nix       # X11 display server configuration
  ];

}
