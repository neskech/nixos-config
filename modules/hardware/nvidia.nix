# NVIDIA GPU Configuration
# Driver setup and optimization for NVIDIA graphics cards
{ config, pkgs, ... }:

{
  # --- 1. The Drivers ---
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is REQUIRED for Wayland/Hyprland and Plymouth.
    modesetting.enable = true;

    # Desktop GPUs don't need 'finegrained' power management.
    powerManagement.enable = true;

    # Use the NVidia open source kernel module (Best for RTX 20 series and newer).
    open = true;

    # Enable the Nvidia settings menu (nvidia-settings).
    nvidiaSettings = true;

    # Use the production driver version.
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # --- 2. The initrd (Early Boot) ---
  # These settings ensure the GPU driver loads as soon as the computer turns on.
  boot.initrd = {
    # Loads the Nvidia modules during the "Initial RAM Disk" phase.
    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    
    # Modernizes the early boot process.
    systemd.enable = true;
  };

  # --- 3. Kernel Parameters ---
  # These "flags" tell the kernel and driver how to behave.
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" # Enables Kernel Mode Setting (Crucial for Wayland)
    "nvidia-drm.fbdev=1"   # Needed for Plymouth to show the splash screen on Nvidia
  ];
}
