# Miscellaneous Configuration
# Antivirus tools, Monitoring, etc.
{ config, pkgs, ... }:

let 
  # We define the list of packages here at the top
  monitors = with pkgs; [
    # --- The Only Info Tools You Need ---
    neofetch             # The classic "What am I running?" tool
    btop                 # The best visual system monitor (CPU/RAM/Disk)
    bottom               # Another visual system monitor (CPU/RAM/Disk)
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
    piper            # Modify input hardware like mouse and keyboard
  ];
in
{

  # USB Automounting
  services.gvfs.enable = true;

  # Enables printing
  services.printing.enable = true;

  # Music Player Daemon. Plays music in the background; very low resource usage.
  services.mpd.enable = true;

  # --- System Packages ---
  # This pulls in the 'monitors' list we defined in the 'let' block above
  environment.systemPackages = monitors ++ misc;
}