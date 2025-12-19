{ pkgs, lib, ... }:
let
  # Define the specific theme/cursor packages so we can use them in both places
  # This ensures the folder name matches exactly what we install.
  
  # 1. Force the Macchiato Blue variant (Default catppuccin-gtk is Mocha)
  my-gtk-theme = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    variant = "macchiato";
  };

  # 2. Force the Macchiato Blue Cursor
  my-cursor-theme = pkgs.catppuccin-cursors.macchiatoBlue;
  
in {
  programs.regreet.enable = true;

  programs.regreet.settings = {
    background = {
      path = ./dotfiles/.tg-wallpapers/greet.jpg;
      fit = "Cover";
    };
    GTK = {
      # THE CRITICAL FIXES:
      # 1. Recent NixOS versions use lowercase names with "+default" suffix
      theme_name = lib.mkForce "catppuccin-macchiato-blue-standard+default"; 
      
      # 2. Cursor names are also often lowercase now
      cursor_theme_name = lib.mkForce "catppuccin-macchiato-blue-cursors"; 
      
      # 3. Use Papirus-Dark (ensure package is installed below)
      icon_theme_name = lib.mkForce "Papirus-Dark";
      
      font_name = lib.mkForce "JetBrainsMono Nerd Font 12";
    };
  };

  # ... (Keep your extraCss and greetd settings the same) ...
  programs.regreet.extraCss = ''
    .login-box {
      border-radius: 15px;
      padding: 20px;
    }
  '';
  
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.dbus}/bin/dbus-run-session ${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };

  users.users.greeter.extraGroups = [ "video" "render" ];

  # INSTALL THE PACKAGES DEFINED ABOVE
  environment.systemPackages = [
    my-gtk-theme     # Installs the Macchiato Blue variant
    my-cursor-theme  # Installs the Macchiato Blue cursor
    pkgs.papirus-icon-theme
    # If you want the folder icons to match Catppuccin, add this too:
    pkgs.catppuccin-papirus-folders 
  ];
}