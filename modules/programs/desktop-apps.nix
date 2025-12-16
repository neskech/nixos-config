# Desktop Applications Configuration
# User-facing graphical applications
{ config, pkgs, ... }:

{
  # Install desktop applications system-wide
  environment.systemPackages = with pkgs; [
    google-chrome   # Web browser
    discord         # Communication and messaging platform
  ];

}
