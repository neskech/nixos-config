{ ... }:

{
  # --- Nix Package Manager Settings ---
  nix.settings = {
    # Unlocks modern Nix features. 
    # 'flakes' is essential for modern, reproducible NixOS setups.
    experimental-features = [ "nix-command" ];  # TODO: Add flakes later  

    # BINARY CACHES (Substituters):
    # These are 'warehouses' for pre-compiled software. 
    # Nix will check these URLs for a ready-to-use version of a package 
    # before trying to compile it from scratch on your CPU.
    substituters = [
      "https://cache.nixos.org"    # Official NixOS binaries
      # "https://numtide.cachix.org" # Binaries for Numtide projects (like devenv)
      # "https://devenv.cachix.org"  # Specific binaries for the 'devenv' tool
    ];

    # SECURITY KEYS:
    # Digital signatures used to verify that the binaries downloaded 
    # from the caches above are authentic and safe to run.
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      #"numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      #"devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
}