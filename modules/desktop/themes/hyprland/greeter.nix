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
    .login-box {
      /* Dark background with 70% opacity (adjust the 0.7 to taste) */
      background-color: rgba(36, 39, 58, 0.7); 
      border-radius: 15px;
      padding: 20px;
      /* Optional: subtle border to make it pop like your waybar */
      border: 1px solid rgba(183, 189, 248, 0.3);
    }

    /* 2. Hide the Top Bar Clock/Time */
    .clock {
      opacity: 0;
      margin-top: -100px; /* Moves it off-screen if opacity fails */
    }

    /* 3. Glassy Power/Session Buttons */
    /* This targets the buttons in the bottom bar (shutdown, reboot) */
    window flowboxchild {
      background-color: rgba(36, 39, 58, 0.5);
      border-radius: 10px;
      margin: 5px;
    }
    
    /* Make them light up slightly on hover */
    window flowboxchild:hover {
      background-color: rgba(36, 39, 58, 0.9);
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