{ config, pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  #  AUDIO (PIPEWIRE)
  # ----------------------------------------------------------------------------
  # Enable sound with pipewire.
  # Disable the legacy audio server to prevent conflicts
  services.pulseaudio.enable = false;
  
  # Grants audio processes high priority to prevent stuttering/crackling
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    
    # Enable ALSA (Advanced Linux Sound Architecture) support
    alsa.enable = true;
    # Required for 32-bit software and many Steam games
    alsa.support32Bit = true;
    
    # Enable PulseAudio emulation (most modern apps need this)
    pulse.enable = true;
    
    # The session manager that handles device routing and logic
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Example hardware-related packages
    # pavucontrol    # Audio mixer for PulseAudio
    # pulsemixer     # Command-line audio mixer
  ];

}