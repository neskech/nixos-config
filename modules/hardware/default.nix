# Hardware Configuration Module
# Aggregates hardware-specific configurations
{ config, pkgs, ... }:

{
  # Import hardware modules
  imports = [
    ./nvidia.nix     # NVIDIA GPU configuration
    ./sound.nix      # Sound card and audio settings
    ./bluetooth.nix  # Bluetooth device configuration
  ];

}
