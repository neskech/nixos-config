# User Accounts Configuration
# Defines system users and their permissions
{ config, pkgs, ... }:

{
  # Define the 'ness' user account
  users.users.ness = {
    # A non-root user
    isNormalUser = true;   
    # 'tss' is critical for the TPM2 security.        
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "tss" ];
    # Fish is the default shell
    shell = pkgs.fish;
    # Intial password
    initialPassword = "bitch";
  };

  # Give your user more "RAM-disk" space for temporary app data.
  # Highly recommended for high-performance Wayland/AI setups.
  services.logind.settings.Login = {
    RuntimeDirectorySize="8G";
  };

}
