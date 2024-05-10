{ pkgs
, inputs
, ...
}:
{
  home.packages = with pkgs; [
    hack-font
    monaspace

    nixpkgs-fmt
    nixd
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
    pavucontrol
    pulseaudio
    shared-mime-info
    # pantheon.elementary-files
    pcmanfm
    xournalpp

    gnome.nautilus
    gnome.file-roller
    gnome.sushi
    gnome.eog

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

    ffmpeg
    curlie # replacement for httpie
    bat # cat but with highlights
    duf # beauty df
    tldr # cheatsheets for cli
    procs # modern ps
    jq
    bitwarden-cli
    htop
    btop
    powertop
    inetutils
    nfs-utils

    tmux
    unzip
    wget
    tree

    plantuml

    # GUI
    # wpsoffice
    # onlyoffice-bin
    libreoffice

    anytype
    anki-bin

    stable.bitwarden

    evince
    gthumb
    pinta
    # (gimp-with-plugins.override {
    #   plugins = with gimpPlugins; [ resynthesizer ];
    # })
    mpv
    unstable.telegram-desktop
    xsane
    simple-scan
    spotify

    slack
    inputs.activate-linux.defaultPackage.x86_64-linux
    scrcpy

    # Web
    thunderbird

    # LaTeX
    texlive.combined.scheme-full
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

    nil # nix language server
    nixd
    alejandra # nix formatting tool

    dbeaver
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
