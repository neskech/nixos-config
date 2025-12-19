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
    /* 1. Glassy Login Box */
    /* Instead of a class, we target the generic vertical box inside the overlay */
    window overlay > box {
      background-color: rgba(36, 39, 58, 0.5); 
      border-radius: 15px;
      padding: 30px;
      border: 1px solid rgba(138, 173, 244, 0.3);
    }

    /* 2. Hide the Top Bar Clock */
    /* CRITICAL CHANGE: Use '#' for ID, not '.' for class */
    #clock {
      opacity: 0;
      /* If opacity fails, move it off screen */
      margin-top: -200px;
    }

    /* 3. Glassy Power Buttons */
    /* Target the buttons inside the flowbox at the bottom */
    flowboxchild {
      background-color: rgba(36, 39, 58, 0.5);
      border-radius: 10px;
      padding: 5px;
      margin: 5px;
    }
    
    flowboxchild:hover {
      background-color: rgba(36, 39, 58, 0.8);
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