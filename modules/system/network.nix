# Network Configuration
# Sets up networking and connectivity management
{ config, pkgs, ... }:

{
  # Enable NetworkManager for network connectivity
  networking.networkmanager.enable = true;

}
