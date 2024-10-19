{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    hack-font
    monaspace

    shfmt

    age

    ###################
    # Packages for DE #
    ###################
    wdisplays
    wf-recorder

    ffmpegthumbnailer
    pamixer
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

    inputs.activate-linux.defaultPackage.x86_64-linux
    scrcpy

    zed-editor

    # Web
    thunderbird-128

    # LaTeX
    texliveFull
    texlab
    # (texlive.combine { inherit (texlive) scheme-medium titlesec wrapfig; })

    # Dev
    yarn
    semver
    envsubst
    clang-tools
    kubectl
    kubectx
    sqlite
    postgresql_13
    coreutils
    grpc
    grpc-gateway
    grpcurl # grpc client
    nodejs
    jetbrains-toolbox
    jetbrains.idea-ultimate
    # intellij-idea-ultimate
    sops

    nixd # nix language server
    alejandra # nix formatting tool
    dprint

    stable.dbeaver-bin
    beekeeper-studio

    gcc
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    openapi-generator-cli

    nodePackages.yaml-language-server
    nodePackages.prettier
    nodePackages.vue-language-server
    nodePackages.eslint
    nodePackages.yaml-language-server

    gnumake
    zip

    # steam-run-native
    chiaki

    chromium
  ];
}
