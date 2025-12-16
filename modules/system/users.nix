{ config, pkgs, ... }:

{
 
  users.users.ness = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };

}
