{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    theme = "catppuccin-macchiato";
    # Ensure we override the package to get the correct color variant
    themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "macchiato"; }) ];
  };

  boot.kernelParams = [
    "video=efifb:off"
  ];
}