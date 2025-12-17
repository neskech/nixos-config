# Miscellaneous Configuration
# Antivirus tools, Monitoring, etc.
{ config, pkgs, ... }:

let 
  # We define the list of packages here at the top
  monitors = with pkgs; [
    # --- The Only Info Tools You Need ---
    neofetch             # The classic "What am I running?" tool
    btop                 # The best visual system monitor (CPU/RAM/Disk)
    nvtopPackages.nvidia # The best way to monitor your Nvidia GPU
    
    # --- Essential Hardware/Network Utilities ---
    gpu-viewer           # For when you need to see deep driver/Vulkan specs
    wlr-randr            # Mandatory for managing monitors on Hyprland
    dig                  # Essential for checking if your DNS/Adblock is working
    speedtest-rs         # Fast way to check if your internet is slow
  ];

  # Utulities not specific to any desktop environment like wayland,
  # X11, etc. All those packages go in modules/desktop/themes/...
  misc = with pkgs; [
    gammastep        # Automatic screen dimming / night light
    brightnessctl    # Brightness controller and keyboard lights
    xdg-utils        # Essential for "Open with..." and link handling
    playerctl        # Controls media (Play/Pause/Skip) via keyboard shortcuts
    at-spi2-atk      # Required for many GUI apps to behave correctly
  ];
in
{

  # Enable the background service for screen dimming
  services.gammastep = {
    enable = true;
    
    # This tells Gammastep to look at your GeoClue2 config for coordinates
    # See the locale config for installation of geoclue
    locationSource = "geoclue2";

    # Temperature settings (6500K is normal/blue, 3500K is warm/orange)
    settings = {
      general = {
        temp-day = 6500;
        temp-night = 3500;
        fade = 1; # Makes the transition smooth
      };
    };
  };

  # USB Automounting
  services.gvfs.enable = true;

  # Enables printing
  services.printing.enable = true;

  # Music Player Daemon. Plays music in the background; very low resource usage.
  services.mpd.enable = true;

  # --- System Packages ---
  # This pulls in the 'monitors' list we defined in the 'let' block above
  environment.systemPackages = monitors;
}