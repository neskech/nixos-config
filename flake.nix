{
  description = "Ness's High-Performance NixOS & Home Manager Flake";

  inputs = {
    # The core NixOS package source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager for user-specific configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # Tells Home Manager to use the same version of nixpkgs as the system
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    # Replace 'nixos' with your actual hostname if it is different
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # This is the CRITICAL fix: it passes 'inputs' to all your modules
      specialArgs = { inherit inputs; };

      modules = [
        # Your main system configuration file
        ./hosts/desktop/configuration.nix
        
        # This allows you to use the 'home-manager' block inside your modules
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Ensure inputs are available inside Home Manager modules too
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}