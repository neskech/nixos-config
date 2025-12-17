{ pkgs, ... }:

{
  # 1. sudo-rs: Fast, memory-safe privilege escalation.
  # Replaces the old C-based 'sudo' with almost zero overhead.
  security.sudo-rs.enable = true;
  security.sudo.enable = false;

  # 2. TPM2: Hardware-level security.
  # This uses the chip already on your motherboard. It consumes 
  # virtually zero CPU/RAM because the work happens on the chip itself.
  security.tpm2.enable = true;

  # 3. ClamAV: An antivirus for malware detection.
  services.clamav = {
    daemon.enable = true;
    # Configures the scanning service
    scanner = {
      enable = true;
      path = "/home/ness";
      # Schedule: Every Saturday at 4:00 PM (16:00).
      interval = "Sat *-*-* 16:00:00";
    };
    
    # IMPORTANT: You need the updater (freshclam) to get new virus signatures
    updater.enable = true;
  };
}