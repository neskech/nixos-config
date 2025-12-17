# Desktop Environment Configuration
# Imports desktop manager and window manager configurations
{ config, pkgs, ... }:

{
  # Import desktop environment modules
  imports = [
    ./hyprland.nix
    ./apps.nix
    ./greeter.nix
    ./plymouth.nix
  ];

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];

  environment.systempackages = with pkgs; [
    qt6.qtwayland    # Ensures Qt6 apps look crisp and run natively on Wayland
    waybar           # The status bar (Clock, RAM, CPU, Workspaces)
    rofi              # App launcher / Search bar (Super+D)
    dunst            # Notification daemon (the pop-up alert system)
    avizo            # Visual "Volume/Brightness" pop-up bars on screen
    wlogout          # Graphical Power/Exit menu (Shut down, Sleep, etc)

    # -- Clipboard Management --
    wl-clipboard     # CLI tools for Copy/Paste in Wayland
    wl-clip-persist  # Keeps copied text alive even if the source app is closed
    cliphist         # Stores your copy history so you can paste old items
  ];

}
