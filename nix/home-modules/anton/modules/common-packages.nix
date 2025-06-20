{pkgs, ...}: {
  home.packages = with pkgs; [
    #######################
    # Development Tools   #
    #######################

    # IDE and Code Editors
    neovim # Highly extensible, vim-based text editor
    nixd # Language server for Nix development
    gopls # Official Go language server

    # Code Quality and Formatting
    alejandra # Opinionated Nix code formatter

    # Version Control & Collaboration
    gitAndTools.gh # GitHub's official command-line tool
    glab # GitLab command-line tool

    # Container & Orchestration
    kubectl # Command-line tool for Kubernetes
    kubectx # Tool for switching between kubectl contexts

    ########################
    # Command Line Tools   #
    ########################

    # File Operations
    bat # Modern replacement for cat with syntax highlighting
    ripgrep # Fast pattern searching in files
    tree # Display directory structure
    yazi # Modern, feature-rich terminal file manager
    unzip # Extract ZIP archives
    zip # Create ZIP archives

    # System Monitoring
    btop # Resource monitor with CPU, memory, disks, network
    htop # Interactive process viewer
    procs # Modern replacement for ps command

    # Network Tools
    curlie # Frontend for curl with httpie-like interface
    dig # DNS lookup utility
    inetutils # Collection of common network utilities
    wget # File download utility

    # System Utilities
    coreutils # GNU core utilities
    duf # User-friendly disk usage utility
    tmux # Terminal multiplexer

    # Data Processing
    jq # Command-line JSON processor
    tldr # Simplified man pages

    ########################
    # Development SDKs     #
    ########################

    gradle

    # Python Environment
    python3
    python3Packages.pip

    # Node.js Environment
    # npm

    # Protocol Buffers & gRPC
    grpc # High-performance RPC framework
    grpcurl # Command-line tool for interacting with gRPC servers
    protobuf # Protocol buffers compiler and library
    protoc-gen-go # Protocol buffer compiler plugin for Go
    protoc-gen-go-grpc # gRPC compiler plugin for Go

    ########################
    # Database Tools       #
    ########################

    postgresql # PostgreSQL database engine

    ########################
    # System Tools        #
    ########################

    nixos-rebuild # Tool for rebuilding NixOS system configuration
    sops # Simple and flexible tool for managing secrets
    uv # Python packaging and venv management tool

    ########################
    # Media & Documents   #
    ########################

    # Document Processing
    texliveFull # Comprehensive TeX Live distribution
    texlab # LSP server for LaTeX
    imagemagick # Suite for image creation and manipulation
    ghostscript # PostScript and PDF interpreter

    # Media Downloads
    yt-dlp # Feature-rich video downloader


    gnupg
  ];
}
