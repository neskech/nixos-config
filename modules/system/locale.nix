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
  ];

  # --- 6. Enable the Geoclue2 Service ---
  # Geoclue is a system-wide service that provides location information 
  # (latitude, longitude, and altitude). It works by looking at your 
  # IP address, Wi-Fi networks, or specialized hardware (GPS).
  services.geoclue2.enable = true;

  # --- 7. Global Location Provider ---
  # This tells NixOS that 'geoclue2' is the official source of truth 
  # for your physical location when apps request it.
  location.provider = "geoclue2";

  # --- 8. Application-Specific Permissions ---
  # For security, Geoclue doesn't just give your location to any app. 
  # You have to explicitly allow specific apps to "talk" to it.
  services.geoclue2.appConfig = {
      # 'gammastep' is a tool that adjusts screen color based on the sun's 
      # position. It needs Geoclue to know when sunset occurs at your location.
      # It's installed and configured in programs/misc.nix.
      "gammastep" = {
        # Grants permission to access the location data.
        isAllowed = true;
        
        # 'false' means this is a user-level app, not a core system service.
        isSystem = false;
        
        # The User ID allowed to use this app with Geoclue. 
        # On NixOS, the first user created is almost always "1000".
        users = [ "1000" ]; 
      };
  };

  # --- 9. Time-Zone-And-Clock ---
  # Sets time zone automatically based on location
  # services from geoclue2.
  services.automatic-timezoned.enable = true;

  # --- For Dual-Booting with Windows ---
  # If you dual-boot, Windows expects the hardware clock to be in Local Time,
  # while Linux expects UTC. This line prevents your clock from being 
  # off by several hours when switching between OSs.
  time.hwClockInLocalTime = true;
}