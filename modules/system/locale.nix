{ pkgs, ... }:

{
  # --- 1. Locale Generation ---
  # We are stripping this down to just American English. 
  # This ensures your system supports all standard English characters and symbols.
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];
  
  # --- 2. Primary System Language ---
  # Sets the main language for all menus, terminal outputs, and system folders.
  i18n.defaultLocale = "en_US.UTF-8";

  # --- 3. Region-Specific Formatting (LC_* Variables) ---
  # This ensures all your units (Miles/Inches), currency ($), and 
  # clock formats (12-hour AM/PM) follow the US standard.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --- 4. Basic Keyboard Layout ---
  services.xserver = {
    # Only 'us' layout.
    xkb.layout = "us";
  };

  # --- 5. Spell-checking Infrastructure ---
  # We removed the Ukrainian and Russian dictionaries. Now, your 
  # spell-checker will focus purely on English.
  environment.systemPackages = with pkgs; [
    hunspell            # The core engine used by almost all Linux apps
    hunspellDicts.en_US # The actual list of English words
  ];;

  # --- 9. Time-Zone-And-Clock ---
  services.automatic-timezoned.enable = "America/New_York";

  # --- For Dual-Booting with Windows ---
  # If you dual-boot, Windows expects the hardware clock to be in Local Time,
  # while Linux expects UTC. This line prevents your clock from being 
  # off by several hours when switching between OSs.
  time.hardwareClockInLocalTime = true;
}