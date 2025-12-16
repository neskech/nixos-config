# NVIDIA GPU Configuration
# Driver setup and optimization for NVIDIA graphics cards
{ config, pkgs, ... }:

{
  # Configure NVIDIA driver
  hardware.nvidia = {
    modesetting.enable = true;                                    # Enable kernel mode setting
    package = config.boot.kernelPackages.nvidiaPackages.stable;   # Use stable driver version
    open = false;                                                 # Use proprietary drivers
  };

  # Enable hardware graphics acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for Steam, Discord, and gaming
  };
  
  # Set NVIDIA as the X11 video driver
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # Enable DRM modeset for better power management
  boot.kernelParams = [ "nvidia-drm-modeset=1" ];
}
