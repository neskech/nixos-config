{ config, pkgs, ... }:

{

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;  
  };

hardware.graphics = {
  enable = true;
  enable32Bit = true; # Critical for Steam, Discord, and some games
};
  
  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = [ "nvidia-drm-modeset=1" ];
 
}
