# Development Tools Configuration
# Essential programming and version control tools
{ config, pkgs, ... }:

{
  # Install development tools system-wide
  environment.systemPackages = with pkgs; [
    # Text editors and IDEs
    vim                # Classic text editor
    vscode             # Visual Studio Code editor
    
    # Version control
    git                # Distributed version control system
    gh                 # GitHub command-line interface
    
    # Code formatting
    nixfmt-rfc-style   # Nix code formatter following RFC style

    repomix          # Download repositories
  ];

}
