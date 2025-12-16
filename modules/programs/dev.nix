{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
     vim
     vscode
     git
     gh
  ];

}
