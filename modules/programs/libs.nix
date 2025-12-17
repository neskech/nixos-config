# Libraries Configuration
{ config, pkgs, ... }:

{
  # Install libraries system-wide
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style   # Nix code formatter following RFC style
  ];

}
