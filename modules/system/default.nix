# System Configuration Module
# Aggregates core system settings and user management
{ config, pkgs, ... }:

{
  # Import system modules
  imports = [
    ./network.nix           # Network and connectivity settings
    ./users.nix             # User accounts and permissions
    ./home-manager.nix      # Home Manager integration
    ./bootloader.nix.       # Bootloader settings
    ./adblock.nix           # Adblocker and DNS encryption
    ./env-variables.nix     # Environment variables
    ./garbage-collector.nix # Deletes obsolete libs and files
    ./locale.nix            # Handles language + spell checking + location services
    ./kernel.nix            # Linux kernel settings
    ./nix.nix               # Nix configuration
    ./swap.nix              # RAM swap configuration
    ./ssh.nix               # SSH settings
  ];

}