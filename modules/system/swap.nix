{ ... }:

{
  # 1. Enable zRAM with high performance settings
  zramSwap = {
    enable = true;
    algorithm = "zstd";      # Best compression ratio for tensors/data
    memoryPercent = 50;      # Use up to half of your RAM for compressed swap
    priority = 100;          # Higher priority than SSD swap
  };

  # 2. Keep an SSD swap file as a "Final Safety Net"
  # This prevents the system from crashing if even the zRAM fills up.
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 32 * 1024;        # 32GB swap file on your SSD
    priority = 0;            # Only used when zRAM is 100% full
  } ];
}