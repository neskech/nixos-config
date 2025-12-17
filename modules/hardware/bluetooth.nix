{ config, pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  #  BLUETOOTH CONFIGURATION
  # ----------------------------------------------------------------------------
  
  # Enable Bluetooth hardware support
  hardware.bluetooth.enable = true;
  
  # Power up the default controller on boot
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages = with pkgs; [
    # https://github.com/kaii-lb/overskride
    overskride
  ];
}