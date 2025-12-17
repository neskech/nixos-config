{ ... }:

{
  # --- Nix Store Optimization ---
  
  # Automatically detects duplicate files in the /nix/store and replaces them 
  # with hard links to a single copy. This runs during the installation of new packages.
  nix.settings.auto-optimise-store = true;

  # Periodically runs a deeper optimization process to find and eliminate 
  # redundant copies of identical files that might have been missed.
  nix.optimise.automatic = true;

  # --- Garbage Collection (GC) ---
  # NixOS keeps every version (generation) of your system so you can roll back. 
  # This section prevents your hard drive from filling up with old versions.

  nix.gc = {
    # Enables the automatic garbage collection service.
    automatic = true;

    # How often to run the cleanup. "weekly" is a safe default.
    dates = "weekly";

    # The rules for what to delete:
    # "--delete-older-than 14d" means it will keep every system version you've 
    # created in the last 2 weeks, but delete anything older than that.
    options = "--delete-older-than 14d";
  };
}