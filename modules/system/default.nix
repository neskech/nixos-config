# System Configuration Module
# Aggregates core system settings and user management
{ config, pkgs, ... }:

{
  # Import system modules
  imports = [
    ./network.nix   # Network and connectivity settings
    ./users.nix     # User accounts and permissions
  ];

}
