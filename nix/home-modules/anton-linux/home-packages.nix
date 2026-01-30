{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #######################
    # Desktop Environment #
    #######################

    # File Management
    nautilus # Modern file manager for GNOME
    file-roller # Archive manager for GNOME
    sushi # Quick file previewer for Nautilus

    # Document Viewing
    evince # Document viewer supporting PDF and other formats
    eog # Eye of GNOME image viewer

    # System Integration
    xdg-utils # Tools for desktop integration
    libnotify # Desktop notification library
    simple-scan # Document scanning utility
    pwvucontrol # PipeWire volume control
    ffmpegthumbnailer # Video thumbnail generator

    ########################
    # System Utilities     #
    ########################

    shfmt # Shell script formatter
    age # Modern file encryption tool
    powertop # Power consumption analyzer
    scrcpy # Android device mirroring

    ########################
    # Fonts               #
    ########################

    font-awesome # Icon font for UI elements
    monaspace # Modern monospace coding font
    iosevka # Highly configurable programming font
    inter # Clean sans-serif font for interfaces
    liberation_ttf # Metrically compatible with MS fonts

    ########################
    # Productivity Apps    #
    ########################

    # Office & Notes
    libreoffice # Full-featured office suite
    # xournalpp # Note-taking and PDF annotation
    obsidian # Markdown-based note-taking
    anki-bin # Spaced repetition learning
    thunderbird-latest # Email and calendar client

    ########################
    # Media Applications  #
    ########################

    # Image Editing
    gimp3 # Professional image editor
    pinta # Simple image editor
    gthumb # Image viewer and organizer

    # Video & Audio
    mpv # Versatile media player
    shotcut # Video editor
    lightworks # Professional video editing

    ########################
    # Communication       #
    ########################

    telegram-desktop # Messaging platform
    zoom-us

    ########################
    # Development Tools   #
    ########################

    # Version Control
    glab # GitLab CLI

    # Command Line Tools
    bat # Modern cat replacement
    btop # System resource monitor
    curlie # HTTP client
    dig # DNS lookup utility
    duf # Disk usage utility
    htop # Process viewer
    inetutils # Network utilities
    jq # JSON processor
    procs # Process management
    ripgrep # Fast text search
    yazi # Terminal file manager
    tmux # Terminal multiplexer
    unzip # Archive extraction
    wget # File downloader
    tree # Directory viewer
    plantuml # UML diagram generator

    # Kubernetes Tools
    kubectl # Kubernetes CLI
    kubectx # Context switcher

    # Programming Tools
    coreutils # GNU utilities
    grpc # RPC framework
    grpcurl # gRPC testing tool
    nodejs # JavaScript runtime
    postgresql_17 # Database server
    sops # Secrets management
    devpod # Development environments
    gcc # GNU Compiler Collection
    protobuf # Data serialization
    protoc-gen-go # Go protobuf generator
    protoc-gen-go-grpc # Go gRPC generator
    gnumake # Build automation
    zip # Archive creation
    # uv # Python package manager

    # Editors & IDEs
    zed-editor # Modern code editor
    # neovim # Terminal editor
    vscodium.fhs # Open source VS Code
    # jetbrains-toolbox # JetBrains IDE manager
    # jetbrains.idea-ultimate # Java IDE
    nixd # Nix language server
    alejandra # Nix formatter
    dprint # Code formatter
    opencode # Opencode CLI

    # Database Tools
    dbeaver-bin # Universal database tool

    # Network TUI tools
    bluetui
    impala

    ########################
    # Security            #
    ########################

    bitwarden-desktop # Password manager

    ########################
    # Web Browsers       #
    ########################

    chromium # Open source browser
    # zen

    ########################
    # Documentation      #
    ########################

    texliveFull # TeX distribution
    texlab # LaTeX language server
  ];
}
