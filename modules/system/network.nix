# Network Configuration
# Sets up networking and connectivity management
{ config, pkgs, ... }:

{
  # Enable NetworkManager for network connectivity
  # --- Network Manager + iwd Backend ---
  networking.networkmanager = {
    enable = true;
    # This is the "Magic Link": It tells NetworkManager to use the fast iwd 
    # engine instead of the old, slow wpa_supplicant.
    wifi.backend = "iwd";
  };

  # Enable firewall
  networking.firewall.enable = true;

  # --- 1. Identity ---
  # The name of your machine on the local network.
  networking.hostName = "Nexus";

  # --- 2. The Wireless Engine (iwd) ---
  # We use iwd because it is faster and more lightweight than wpa_supplicant.
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        # Allows iwd to assign itself an IP address (built-in DHCP client).
        EnableNetworkConfiguration = true;
      };
      Network = {
        # Enables modern IPv6 support.
        EnableIPv6 = true;
      };
      Scan = {
        # Stops background scanning. Essential for gamers to prevent 
        # momentary lag/stutter every 60 seconds.
        DisablePeriodicScan = true;
      };
    };
  };

  # --- 3. Networking Packages ---
  environment.systemPackages = with pkgs; [
    impala # Terminal Wi-Fi manager (Fast and lightweight)
  ];

}
