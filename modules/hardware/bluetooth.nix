{ config, pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  #  BLUETOOTH CONFIGURATION
  # ----------------------------------------------------------------------------
  
  # Enable Bluetooth hardware support
  hardware.bluetooth.enable = true;
  
  # Power up the default controller on boot
  hardware.bluetooth.powerOnBoot = true;

  # This provides the backend pairing agent that Overskride uses
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    # Bluetooth GUI https://github.com/kaii-lb/overskride
    overskride
  ];
}