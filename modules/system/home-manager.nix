# Home Manager Configuration
{ config, pkgs, ... }:

{
  # Home Manager settings will be defined here

  home-manager.users.ness = { pkgs, ... }: {
    home.stateVersion = "24.11";
  };
  
  # Backup files that Home Manager manages
  home-manager.backupFileExtension = "backup";
}