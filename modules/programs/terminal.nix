

{ inputs, pkgs, ... }:

{
  # High quality interactive shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Mirror the Nix-LD libraries to the standard LD path so Python can find them
      set -gx LD_LIBRARY_PATH $NIX_LD_LIBRARY_PATH
    '';
  };

  environment.systemPackages = with pkgs; [
    # -- Terminals & Editors --
    kitty         # Another fast terminal with great image support
    starship      # A good looking terminal bar
    zellij        # Terminal multiplexer (panes and tabs)

    # -- Modern CLI Replacements --
    bat           # cat with wings (syntax highlighting)
    lsd           # ls with icons
    fd            # Simple 'find' replacement
    zoxide        # 'cd' that learns your habits
    duf           # Disk usage with colors
    ncdu          # Visual directory space usage
    procs         # Process viewer (better 'ps')
    tealdeer      # Fast 'tldr' (simplified man pages)

    # -- File & Archive Management --
    ouch          # One tool for all compression (zip, tar, etc.)
    trash-cli     # Move files to trash instead of permanent 'rm'
    fzf           # Fuzzy finder (search through lists instantly)
    jq            # JSON processor
    
    # -- Network & Transfer --
    yt-dlp        # Download videos from YouTube and 1000+ other sites

    # -- System Monitoring & Productivity --
    topgrade      # One command to upgrade everything (Nix, flatpak, etc.)
    tokei         # Counts lines of code in your projects

    # -- Dev CLI Tools --
    vim     # Classic text editor
    wget    # File download utility
    tree    # Directory tree visualization tool
    git     # Distributed version control system
    gh      # GitHub command-line interface
   # repomix # Download repositories into AI friendly file
    
    # -- Fun / Aesthetics --
    cava          # Audio visualizer
    cbonsai       # Terminal bonsai tree
    cmatrix       # Matrix digital rain
    lolcat        # Rainbow colors for your terminal text
  ];
}