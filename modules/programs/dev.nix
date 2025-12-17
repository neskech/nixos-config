# Development Tools Configuration
# Essential programming and version control tools
{ config, pkgs, ... }:

let
  language = with pkgs; [
    uv 
    bun
    nodePackages_latest.nodejs
    nodePackages_latest.npm
    python313
  ];

  lsp = with pkgs; [
    # --- Python ---
    python313Packages.python-lsp-server # Comprehensive LSP for Python (autocompletion, definitions)

    # --- Node.js & Web Development ---
    nodePackages_latest.nodemon                      # Automatically restarts node apps when file changes are detected
    nodePackages_latest.typescript                   # The TypeScript compiler (tsc)
    nodePackages_latest.typescript-language-server   # LSP for TypeScript and JavaScript
    eslint                                           # Pluggable linting utility for JavaScript/TypeScript
    biome                                            # Fast all-in-one toolchain (formatter/linter) for web languages
    nodePackages_latest.vscode-langservers-extracted # Built-in VS Code servers for HTML, CSS, JSON, and ESLint
    emmet-language-server                            # Expands HTML/CSS abbreviations (e.g., div.main -> <div class="main">)

    # --- Configs & Data Formats ---j
    nodePackages_latest.yaml-language-server             # LSP for YAML files (used in CI/CD, Kubernetes)
    taplo                                            # High-performance TOML tool (formatter and LSP)
    nodePackages_latest.bash-language-server # LSP for Shell scripting (Bash)
    dockerfile-language-server                        # LSP for writing Dockerfiles
    docker-compose-language-service                  # LSP for multi-container Docker Compose files
    cmake-language-server                            # LSP for CMake build scripts
    terraform-ls                                     # LSP for HashiCorp Terraform (Infrastructure as Code)
    hyprls                                           # LSP specifically for Hyprland configuration files

    # --- Low-Level & Systems Languages ---
    vscode-extensions.vadimcn.vscode-lldb # CodeLLDB debugger (great for C, C++, and Rust)

    # --- Documentation & Markup ---
    markdown-oxide                       # A high-performance Markdown LSP written in Rust

    # --- Specialized Tools ---
    buf                                  # Tool for working with Protocol Buffers (Protobuf)
  ];
in
{
  # Install development tools system-wide
  environment.systemPackages = language ++ lsp;

}
