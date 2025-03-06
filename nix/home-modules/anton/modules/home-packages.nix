{pkgs, ...}: {
  home.packages = with pkgs; [
    ####################
    # System Utilities #
    ####################
    shfmt # A shell script formatter that formats shell scripts automatically.
    age # A simple, modern, and secure file encryption tool.
    libnotify # A library for sending desktop notifications.
    xdg-utils # Tools for integrating with the XDG desktop environment.
    powertop # A tool to diagnose power consumption issues.
    scrcpy # A tool to control Android devices from the desktop.

    #######################
    # Desktop Environment #
    #######################
    wdisplays # A graphical tool for managing and configuring displays.
    ffmpegthumbnailer # A lightweight video thumbnailer that uses ffmpeg.
    pwvucontrol # A volume control tool for PipeWire.
    nautilus # The GNOME file manager.
    file-roller # An archive manager for GNOME.
    sushi # A quick previewer for files in GNOME.
    eog # Eye of GNOME, an image viewer.
    evince # A document viewer for PDFs and other formats.
    simple-scan # A simple document scanning tool.

    ###########
    # Fonts   #
    ###########
    font-awesome # A popular icon font.
    monaspace # A modern monospaced font designed for code readability.
    inter # A highly readable font for UI and text.
    liberation_ttf # A font family that replaces common Microsoft fonts.

    ####################
    # Productivity     #
    ####################
    xournalpp # A handwriting notetaking software with PDF annotation support.
    libreoffice # A free and open-source office suite.
    anytype # A note-taking and organization tool.
    anki-bin # A spaced repetition flashcard program.
    thunderbird # A popular email client.

    ####################
    # Media & Graphics #
    ####################
    gthumb # An image viewer and organizer.
    pinta # A lightweight image editing tool.
    mpv # A versatile media player.
    spotify # A music streaming service.

    ####################
    # Communication    #
    ####################
    telegram-desktop # A desktop client for Telegram.
    slack # A desktop client for Slack.

    ####################
    # Development      #
    ####################
    # CLI Tools
    gitAndTools.gh # GitHub CLI for interacting with GitHub from the command line.
    glab # A GitLab CLI tool.
    bat # A `cat` replacement with syntax highlighting.
    btop # A modern resource monitor for processes and system usage.
    curlie # A user-friendly alternative to `httpie` for HTTP requests.
    dig # A DNS lookup utility.
    duf # A more user-friendly alternative to `df` for disk usage.
    htop # An interactive process viewer.
    inetutils # A collection of common network utilities.
    jq # A command-line JSON processor.
    procs # A modern replacement for `ps` with additional features.
    ripgrep # A fast and efficient search tool for files.
    tldr # Simplified and community-driven man pages.
    yazi # A terminal file manager.
    tmux # A terminal multiplexer for managing multiple terminal sessions.
    unzip # A utility for extracting ZIP archives.
    wget # A command-line tool for downloading files from the web.
    tree # A command-line tool to display directory structures.
    plantuml # A tool for creating UML diagrams from text.

    # Programming Languages & Tools
    clang-tools # A collection of Clang-based tools for C/C++ development.
    coreutils # GNU core utilities for basic file and text operations.
    grpc # A high-performance RPC framework.
    grpcurl # A command-line tool for interacting with gRPC servers.
    nodejs # A JavaScript runtime for server-side development.
    postgresql_13 # A powerful open-source relational database.
    sops # A tool for managing encrypted secrets.
    devpod # A tool for managing development environments.
    gcc # The GNU Compiler Collection for C/C++.
    protobuf # A protocol buffers library for serializing structured data.
    protoc-gen-go # A Go plugin for generating protobuf code.
    protoc-gen-go-grpc # A Go plugin for generating gRPC code.
    gnumake # A build automation tool.
    zed-editor # High performance editor
    zip # A compression and file packaging utility.

    # IDEs & Editors
    jetbrains-toolbox # A tool for managing JetBrains IDEs.
    master.jetbrains.idea-ultimate # JetBrains IntelliJ IDEA Ultimate edition.
    nixd # A language server for Nix.
    alejandra # A Nix code formatter.
    dprint # A pluggable and configurable code formatting platform.

    # Database Tools
    dbeaver-bin # A universal database tool for developers.
    beekeeper-studio # A modern SQL editor and database manager.

    ####################
    # Security         #
    ####################
    bitwarden # A password manager with cloud sync.

    ####################
    # Web Browsers     #
    ####################
    chromium # An open-source web browser.

    #########################
    # LaTeX & Documentation #
    #########################
    texliveFull # A full LaTeX distribution.
    texlab # A Language Server Protocol implementation for LaTeX.
  ];
}
