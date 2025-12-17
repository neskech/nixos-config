# X11 Display Server Configuration
# Sets up X11 with GDM display manager and auto-login
{ config, pkgs, ... }:

{
  # Enable X11 display server
  services.xserver.enable = true;
  
  # Use GNOME Display Manager for login screen
  services.displayManager.gdm.enable = true;
  
  # Configure auto-login settings
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ness";
}
