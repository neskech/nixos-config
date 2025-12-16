{ config, pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  #  AUDIO (PIPEWIRE)
  # ----------------------------------------------------------------------------
  # Enable sound with pipewire.
  services.pulseaudio.enable = false; # Disable older PulseAudio
  security.rtkit.enable = true;      # Real-time kit for audio priority
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this:
    # jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Example hardware-related packages
    pavucontrol    # Audio mixer for PulseAudio
    pulsemixer     # Command-line audio mixer
  ];

}