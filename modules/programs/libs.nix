# Libraries Configuration
{ config, pkgs, ... }:

{
  # Install libraries system-wide
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style   # Nix code formatter following RFC style
  ];

  programs.nix-ld.enable = true;
  
  # Sets up a "standard" library environment for binaries to find
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib  # <--- This provides libstdc++.so.6
    zlib              # Common dependency for numpy/torch
    glib              # Often needed by opencv/machine learning libs
    libGL             # Needed if you use cv2 (OpenCV)
  ];

}
