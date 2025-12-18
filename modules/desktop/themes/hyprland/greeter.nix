{ pkgs, config, lib, ... }:

{
  # 1. Enable ReGreet
  # https://github.com/rharish101/ReGreet/
  programs.regreet.enable = true;

  # 2. Configure the look
  # https://github.com/rharish101/ReGreet/blob/main/regreet.sample.toml
  programs.regreet.settings = {
    background = {
      # Path to your login wallpaper
      path = ./dotfiles/.tg-wallpapers/greet.jpg; 
      fit = "Cover";
    };
    GTK = {
      theme_name = lib.mkForce "catppuccin-macchiato-blue-standard"; # Removed +default
      icon_theme_name = lib.mkForce "Papirus-Dark";
      cursor_theme_name = lib.mkForce "Catppuccin-Macchiato-Blue-Cursors";
      font_name = lib.mkForce "JetBrainsMono Nerd Font 12";
    };
  };

  programs.regreet.extraCss = ''
        .login-box {
            border-radius: 15px;
            padding: 20px;
        }
  '';

  # 3. Setup the greetd service to launch ReGreet via Cage
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Cage is a minimal Wayland compositor that runs exactly one app (regreet)
        command = "${pkgs.cage}/bin/cage -s -- ${config.programs.regreet.package}/bin/regreet";
        user = "greeter";
      };
    };
  };

  # Ensure the greeter user can actually use the screen/GPU
  users.users.greeter.extraGroups = [ "video" "render" ];

  # Help GTK/Cage find the themes
  services.greetd.settings.default_session.command = lib.mkForce (
    "${pkgs.dbus}/bin/dbus-run-session ${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet"
  );

  # 4. Ensure the themes are actually installed for the greeter user
  environment.systemPackages = with pkgs; [
    catppuccin-gtk
    catppuccin-cursors.macchiatoBlue
    papirus-icon-theme
  ];

}