# Configuration for locale, keyboard, and input methods
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cliphist   # Clipboard history manager
  ];
}