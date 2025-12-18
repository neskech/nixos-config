{ config, pkgs, lib, ... }:

{
  # --- 1. Identity & Version ---
  home.username = "ness";
  home.homeDirectory = "/home/ness";
  # This value determines the Home Manager release that your configuration is
  # compatible with. Do not change this unless you know what you are doing.
  home.stateVersion = "24.11"; 


  # --- 1. Files in ~/.config ---
  # xdg.configFile automatically targets the ~/.config/ directory
  xdg.configFile = {
    "avizo".source = ./dotfiles/.config/avizo;
    "bat".source = ./dotfiles/.config/bat;
    "btop".source = ./dotfiles/.config/btop;
    "cava".source = ./dotfiles/.config/cava;
    "delta".source = ./dotfiles/.config/delta;
     # Discord breaks if we replace the json file. Do this manually "discord".source = ./dotfiles/.config/discord;
    "dunst".source = ./dotfiles/.config/dunst;
    "fish".source = ./dotfiles/.config/fish;
    "gtk-3.0".source = ./dotfiles/.config/gtk-3.0;
    "gtk-4.0".source = ./dotfiles/.config/gtk-4.0;
    "hypr".source = ./dotfiles/.config/hypr;
    "kitty".source = ./dotfiles/.config/kitty;
    "Kvantum".source = ./dotfiles/.config/Kvantum;
    "neofetch".source = ./dotfiles/.config/neofetch;
    "rofi".source = ./dotfiles/.config/rofi;
    "swappy".source = ./dotfiles/.config/swappy;
    "tealdeer".source = ./dotfiles/.config/tealdeer;
    "waybar".source = ./dotfiles/.config/waybar;
    "wlogout".source = ./dotfiles/.config/wlogout;
    # Only sync the CSS file and not the JSON 
    "YouTube Music/macchiato.css".source = ./dotfiles/.config + "/YouTube Music/macchiato.css";
    "zathura".source = ./dotfiles/.config/zathura;
    "zellij".source = ./dotfiles/.config/zellij;
  };

  # --- 2. Files in the root of $HOME ---
  home.file = {
    # GTK 2.0 legacy config
    ".gtkrc-2.0".source = ./dotfiles/.gtkrc-2.0;

    # Icons and Cursors
    ".icons".source = ./dotfiles/.icons;

    # Wallpapers
    ".tg-wallpapers".source = ./dotfiles/.tg-wallpapers;
  };

  # --- 4. Programs with Managed Configs ---
  # Some programs have "Nix-native" configuration options
  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    userName = "ness";
    userEmail = "neskechastro@gmail.com";
  };

  # Enable the background service for screen dimming
  services.gammastep = {
    enable = true;
    
    # This tells Gammastep to look at your GeoClue2 config for coordinates
    # See the locale config for installation of geoclue
    provider = "geoclue2";

    # Temperature settings (6500K is normal/blue, 3500K is warm/orange)
    settings = {
      general = {
        temp-day = lib.mkForce 6500;
        temp-night = lib.mkForce 3500;
        fade = 1; # Makes the transition smooth
      };
    };
  };

 

}