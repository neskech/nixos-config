{ ... }:

{
  # 1. Force the system to use the local DNSCrypt-Proxy
  networking = {
    nameservers = [ "127.0.0.1" "[::1]" ];
    # Stop NetworkManager/DHCP from overwriting our settings
    networkmanager.dns = "none";
    dhcpcd.enable = false;
    resolvconf.enable = true;
  };

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      # Use high-performance, ad-blocking resolvers only
      server_names = [ 
        "mullvad-adblock-doh" 
        "adguard-dns-doh"
        "quad9-dnscrypt-ipv4-filter-pri" # Blocks malware specifically
      ];

      # Safety and Privacy settings
      require_dnssec = true;  # Verifies the DNS response is real
      require_nolog = true;    # Only use servers that claim they don't log your activity
      require_nofilter = false; # We WANT filtering (ad-blocking)

      # Addresses to listen on
      listen_addresses = [ "127.0.0.1:53" "[::1:53]" ];

      # Sources for the resolver list
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  # Ensures the directory for the cache exists
  systemd.services.dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy";
}