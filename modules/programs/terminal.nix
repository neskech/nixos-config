# Terminal Utilities Configuration
# Command-line tools and utilities
{ config, pkgs, ... }:

{
  # Install terminal utilities system-wide
  environment.systemPackages = with pkgs; [
    wget    # File download utility
    tree    # Directory tree visualization tool
  ];

}
