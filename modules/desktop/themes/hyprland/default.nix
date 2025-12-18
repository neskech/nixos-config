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

  # This tells Nix to rename old files to .backup instead of failing
  home-manager.backupFileExtension = "backup";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    
    users.ness = { pkgs, ... }: {
      imports = [ 
        ./symlink.nix 
      ];
      
      home.stateVersion = "24.11";
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];

}
