# User Accounts Configuration
# Defines system users and their permissions
{ config, pkgs, ... }:

{
  # Define the 'ness' user account
  users.users.ness = {
    isNormalUser = true;            # Create as a normal user (non-root)
    extraGroups = [ "wheel" ];      # Add to wheel group for sudo access
  };

}
