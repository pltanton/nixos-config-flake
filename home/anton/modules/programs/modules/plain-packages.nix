{ pkgs, fetchPypi, inputs, ... }:
let
  gradle2nix = import (fetchTarball {
    url = "https://github.com/tadfisher/gradle2nix/archive/master.tar.gz";
    sha256 = "04skv5nhbqzybxsqp7b7l4s7nl66p8cd92f6czlivwcjnj36lzya";
  }) { pkgs = pkgs; };
in {
  home.packages = with pkgs; [
    hack-font

    gnuplot

    nixfmt
    shfmt

    gnupg

    ###################
    # Packages for DE #
    ###################
    waylandPkgs.wdisplays
    waylandPkgs.wf-recorder

    ffmpegthumbnailer
    pamixer
    paprefs
    pavucontrol
    shared_mime_info
    pantheon.elementary-files

    # Fonts
    font-awesome_5
    emojione
    iosevka-bin
    inter
    #nerdfonts

    #############
    # User apps #
    #############
    # CLI utils
    nix-prefetch-github
    gitAndTools.gh

    ffmpeg
    httpie
    ansible
    dnsutils
    jq
    bitwarden-cli
    htop
    inetutils
    killall
    nfs-utils

    ranger
    tmux
    unzip
    unrar
    wget
    tree

    plantuml

    # GUI
    libreoffice
    audacity
    xournalpp
    discord
    zoom-us
    skype
    transmission-remote-gtk
    transmission-gtk
    stable.rapid-photo-downloader
    evince
    zathura
    gthumb
    gnome-photos
    gimp
    mpv
    tdesktop
    vlc
    xsane
    slack
    spotify
    # steam
    shotcut

    (steam.override {
      # extraPkgs = pkgs: [ SDL2 libstdcxx5 ];
      nativeOnly = false;
    })

    thunderbird
    bitwarden
    sidequest
    scrcpy
    darktable
    # tigervnc

    # Web
    chromium
    # nur.repos.sikmir.qutebrowser-bin

    # LaTeX
    texlive.combined.scheme-full
    texlab
    # (texlive.combine { inherit (texlive) scheme-medium titlesec wrapfig; })

    # Dev
    docker-compose
    clang-tools
    # gradle2nix
    graphviz
    nodejs
    insomnia
    postman
    adoptopenjdk-bin
    #jetbrains.idea-community
    jetbrains.idea-ultimate
    jetbrains.datagrip
    android-studio
    mongodb
    robo3t
    dbeaver
    gcc
    go
    gopls
    gotools
    gocode
    delve # Go debugging tool
    godef
    python38Packages.pip
    (python3.withPackages (pp:
      with pp; [
        pip
        pylint
        jedi
        flake8
        autopep8
        pygments
        hvac
        pika
        python-language-server
      ]))

    nodePackages.yaml-language-server
    nodePackages.prettier
    nodePackages.vue-language-server
    nodePackages.eslint
    gnumake
    zip

    awscli2
    aws-sam-cli
  ];
}
