{pkgs, ...}: {
  home.packages = with pkgs; [
    monaspace

    shfmt
    age

    ###################
    # Packages for DE #
    ###################
    wdisplays

    ffmpegthumbnailer
    paprefs
    pwvucontrol
    pulseaudio
    shared-mime-info
    # pantheon.elementary-files
    pcmanfm
    xournalpp

    nautilus
    file-roller
    sushi
    eog

    # Fonts
    font-awesome
    # emojione
    iosevka
    inter
    liberation_ttf
    #nerdfonts

    #############
    # User apps #
    #############
    # CLI utils
    nix-prefetch-github
    gitAndTools.gh
    libnotify
    xdg-utils
    glab

    bat # cat but with highlights
    bitwarden-cli
    btop
    curlie # replacement for httpie
    dig
    duf # beauty df
    ffmpeg
    htop
    inetutils
    jq
    nfs-utils
    powertop
    procs # modern ps
    ripgrep
    tldr # cheatsheets for cli
    yazi

    tmux
    unzip
    wget
    tree

    plantuml

    # GUI
    # wpsoffice
    # onlyoffice-bin
    libreoffice

    master.anytype
    anki-bin

    bitwarden
    goldwarden

    evince
    gthumb
    pinta
    # (gimp-with-plugins.override {
    #   plugins = with gimpPlugins; [ resynthesizer ];
    # })
    mpv
    telegram-desktop
    slack

    simple-scan
    spotify

    scrcpy

    # zed-editor

    # Web
    thunderbird-128

    # LaTeX
    texliveFull
    texlab
    # (texlive.combine { inherit (texlive) scheme-medium titlesec wrapfig; })

    # Dev
    clang-tools
    coreutils
    envsubst
    grpc
    grpc-gateway
    grpcurl # grpc client
    jetbrains-toolbox
    master.jetbrains.idea-ultimate
    kubectl
    kubectx
    nodejs
    postgresql_13
    semver
    sops
    sqlite
    yarn
    devpod

    nixd # nix language server
    alejandra # nix formatting tool
    dprint

    dbeaver-bin
    beekeeper-studio

    gcc
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    openapi-generator-cli

    nodePackages.yaml-language-server
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.yaml-language-server

    gnumake
    zip

    # steam-run-native
    chiaki

    chromium
  ];
}
