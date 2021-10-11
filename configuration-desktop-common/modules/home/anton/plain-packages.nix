{ pkgs, lib, fetchPypi, inputs, ... }:
let
  gradle2nix = import (fetchTarball {
    url = "https://github.com/tadfisher/gradle2nix/archive/master.tar.gz";
    sha256 = "04skv5nhbqzybxsqp7b7l4s7nl66p8cd92f6czlivwcjnj36lzya";
  }) { pkgs = pkgs; };
in {
  home.packages = with pkgs; lib.mkIf true [
    hack-font

    gnuplot

    nixfmt
    shfmt

    gnupg

    ###################
    # Packages for DE #
    ###################
    wdisplays
    wf-recorder

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
    libnotify

    ffmpeg
    # httpie
    curlie # replacement for httpie
    bat # cat but with highlights
    exa # modern ls
    duf # beauty df
    tldr # cheatsheets for cli
    procs # modern ps
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

    master.easyeffects

    evince
    zathura
    gthumb
    gnome-photos
    gimp
    mpv
    master.tdesktop
    vlc
    xsane
    slack
    spotify
    teams

    thunderbird
    bitwarden
    sidequest
    scrcpy
    darktable
    # tigervnc

    # Web
    chromium
    # nur.repos.sikmir.qutebrowser-bin
    # qutebrowser

    # LaTeX
    texlive.combined.scheme-full
    texlab
    # (texlive.combine { inherit (texlive) scheme-medium titlesec wrapfig; })

    # Dev
    docker-compose
    clang-tools
    kubectl
    kubectx
    # gradle2nix
    graphviz
    nodejs
    insomnia
    postman
    # jetbrains.idea-ultimate
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
    black # Python code formatter
    python-language-server
    python38Packages.pip
    (python3.withPackages (pp:
      with pp; [
        pip
        pylint
        pyright
        jedi
        flake8
        autopep8
        pygments
        hvac
        pika
      ]))

    nodePackages.yaml-language-server
    nodePackages.prettier
    nodePackages.vue-language-server
    nodePackages.eslint
    gnumake
    zip

    stable.awscli2
    stable.aws-sam-cli
  ];
}
