{ pkgs, ... }:

{
  # --- Bootloader Configuration ---
  
  # Enables systemd-boot, a lightweight UEFI boot manager.
  boot.loader.systemd-boot.enable = true;

  # Allows NixOS to update EFI variables (like boot order) in your motherboard's firmware.
  boot.loader.efi.canTouchEfiVariables = true;

  # How long (in seconds) the boot menu stays open before automatically booting the default option.
  boot.loader.timeout = 2;

  # --- Initial RAM Disk (initrd) ---
  # This is the temporary file system used by the kernel during boot to prepare the real root filesystem.

  # Ensures the initial ramdisk is created.
  boot.initrd.enable = true;

  # Reduces the amount of text output during the very early stages of boot.
  boot.initrd.verbose = false;

  # Uses systemd inside the initrd instead of traditional shell scripts (modernizes the boot process).
  boot.initrd.systemd.enable = true;

  # --- Console & Visuals ---

  # Sets the kernel log level. '3' means only show Errors and Critical messages (hides Info/Debug).
  boot.consoleLogLevel = 3;

  # Plymouth provides the graphical "splash screen" (logo/animation) while the system loads.
  boot.plymouth = {
    enable = true;
    
    # Path to the font used by the boot splash for messages or password prompts (decryption).
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    
    # The package containing the specific themes you want to use.
    themePackages = [ pkgs.catppuccin-plymouth ];
    
    # The specific flavor of the Catppuccin theme to display.
    theme = "catppuccin-macchiato";
  };
}