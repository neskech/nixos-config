# SSH Service Configuration
# Manages SSH server settings and remote access
{ config, pkgs, ... }:

{
  # Disable OpenSSH server
  services.openssh.enable = false;

}
