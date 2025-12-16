{ config, pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  #  BLUETOOTH CONFIGURATION
  # ----------------------------------------------------------------------------
  
  # Enable Bluetooth hardware support
  hardware.bluetooth.enable = true;
  
  # Power up the default controller on boot
  hardware.bluetooth.powerOnBoot = true;

  # Enable the Blueman manager (Recommended for Wayland/Hyprland/Niri)
  # This provides the "blueman-manager" GUI and the system tray icon.
  services.blueman.enable = true;
}