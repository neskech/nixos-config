# Programs Module Configuration
# Aggregates all application and tool configurations
{ config, pkgs, ... }:

{
  # Import program-related modules
  imports = [
    ./dev.nix           # Development tools
    ./desktop-apps.nix  # Desktop applications
    ./terminal.nix      # Terminal utilities
  ];

}
