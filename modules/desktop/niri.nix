{ config, pkgs, ... }:

{

  imports = [
     ./wayland.nix
  ];
  
 # Installs niri
 programs.niri.enable = true;

 # Packages niri expects to exist
 environment.systemPackages = with pkgs; [
   alacritty
   fuzzel
   waybar 
 ];
 
}
