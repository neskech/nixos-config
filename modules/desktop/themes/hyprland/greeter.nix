{ pkgs, lib, ... }:
let
  # 1. Force the Macchiato Blue variant
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
      # THE FIX: Lowercase, no "+default", matches your ls output pattern exactly
      theme_name = lib.mkForce "catppuccin-macchiato-blue-standard"; 
      
      # FIX 2: Cursors usually follow the same lowercase pattern
      cursor_theme_name = lib.mkForce "catppuccin-macchiato-blue-cursors"; 
      
      icon_theme_name = lib.mkForce "Papirus-Dark";
      font_name = lib.mkForce "JetBrainsMono Nerd Font 12";
    };
  };

  # ... (Keep extraCss and greetd settings same) ...
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

  # INSTALL THE PACKAGES
  environment.systemPackages = [
    my-gtk-theme
    my-cursor-theme
    pkgs.papirus-icon-theme
  ];
}