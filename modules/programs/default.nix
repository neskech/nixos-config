{ config, pkgs, ... }:

{

   imports = [
   	./dev.nix
        ./desktop-apps.nix
	./terminal.nix
   ];  

}
