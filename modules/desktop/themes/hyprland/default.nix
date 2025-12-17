# Desktop Environment Configuration
# Imports desktop manager and window manager configurations
{ config, pkgs, ... }:

{
  # Import desktop environment modules
  imports = [
    ./hyprland.nix
    ./apps.nix
    ./greeter.nix
    ./plymouth.nix
  ];

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];

}
