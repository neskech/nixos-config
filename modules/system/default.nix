{ config, pkgs, ... }:

{

  imports = [
     ./network.nix
     ./users.nix
  ];

}
