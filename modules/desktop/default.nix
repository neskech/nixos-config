# Desktop Environment Configuration
# Imports desktop manager and window manager configurations
{ config, pkgs, ... }:

{
  # Import desktop environment modules
  imports = [
    ./themes/hyprland
  ];

}
