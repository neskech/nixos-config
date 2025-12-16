# Wayland Environment Variables
# Configuration for wayland compositors and compatibility flags
{ config, pkgs, ... }:

{
  # Set environment variables for wayland session
  environment.sessionVariables = {
    # Enable wayland backend for Electron apps (Chrome, VSCode, Discord, etc)
    NIXOS_OZONE_WL = "1";
    
    # Required for proper window manager interaction with Java applications
    # Necessary for JetBrains IDEs and Minecraft
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

# programs.vscode = {
#   enable = true;
#   package = pkgs.vscode.override {
#     commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
#   };
# };

#  nixpkgs.config = {
#   # Force specific apps to always launch with these arguments
#   chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
#   google-chrome.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
# };
 
}
