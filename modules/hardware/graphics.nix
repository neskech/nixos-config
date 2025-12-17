{ pkgs, ... }:

{
  # Enable Hardware Graphics Acceleration
  hardware.graphics = {
    enable = true;
    # Enables support for 32-bit applications (essential for Steam and many games)
    enable32Bit = true;
    
    # Extra packages for OpenCL and specialized video decoding
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # Helps with hardware video decoding in browsers
      vaapiVdpau          # Video acceleration over VDPAU
      libvdpau-va-gl      # Driver for VDPAU to OpenGL
      nv-codec-headers-12 # Specialized headers for video encoding/decoding
    ];
  };

  # --- 2. Environment Variables ---
  # These tell your system specifically to use the Nvidia driver for video decoding.
  # Without these, your browser might ignore the drivers you just installed.
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    # Required for the nvidia-vaapi-driver to work in Firefox
    NVD_BACKEND = "direct";
  };
}