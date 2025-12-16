{ config, pkgs, ... }:

{
  
environment.sessionVariables = {
  # The "Magic" variable: Tells Electron apps (Chrome, VSCode, Discord, etc) 
  # to use the Wayland backend automatically.
  NIXOS_OZONE_WL = "1";
  
  # Often required for Java apps (like JetBrains IDEs or Minecraft) to behave
  _JAVA_AWT_WM_NONREPARENTING = "1";
};

programs.vscode = {
  enable = true;
  package = pkgs.vscode.override {
    commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
};

 nixpkgs.config = {
  # Force specific apps to always launch with these arguments
  chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  google-chrome.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
};
 
}
