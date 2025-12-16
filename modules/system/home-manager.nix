# Home Manager Configuration
{ config, pkgs, ... }:

{
  # Home Manager settings will be defined here
  imports = [
    # https://nix-community.github.io/home-manager/index.xhtml#ch-introduction
    <home-manager/nixos>      # Home Manager integration 
  ];
}