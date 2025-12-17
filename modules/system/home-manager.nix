# Home Manager Configuration
{ config, pkgs, ... }:

{
  # Home Manager settings will be defined here
imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.ness = { pkgs, ... }: {
    home.stateVersion = "24.11";
  };
  
  # Backup files that Home Manager manages
  home-manager.backupFileExtension = "backup";
}