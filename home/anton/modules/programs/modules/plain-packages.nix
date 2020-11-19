{ pkgs, inputs, ... }:
let
  gradle2nix = import (fetchTarball {
    url = "https://github.com/tadfisher/gradle2nix/archive/master.tar.gz";
    sha256 = "04skv5nhbqzybxsqp7b7l4s7nl66p8cd92f6czlivwcjnj36lzya";
  }) { pkgs = pkgs; };
in {
  home.packages = with pkgs; [
    #nerdfonts
    hack-font
    emacs-all-the-icons-fonts

    gnuplot

    nixfmt

    gnupg

    ###################
    # Packages for DE #
    ###################
    pkgs.wdisplays
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
    fido2luks
    nix-prefetch-github
    gitAndTools.gh

    ffmpeg
    httpie
    ansible
    dnsutils
    jq
    bitwarden-cli
    bitwarden-rofi
    htop
    inetutils
    killall
    nfs-utils

    ranger
    tmux
    unzip
    wget
    tree

    filezilla

    # GUI
    libreoffice
    audacity
    xournalpp
    discord
    zoom-us
    transmission-remote-gtk
    transmission-gtk
    rapid-photo-downloader
    evince
    gthumb
    gnome-photos
    gimp
    mpv
    tdesktop
    vlc
    xsane
    slack
    spotify
    #steam
    thunderbird
    bitwarden
    sidequest
    scrcpy
    darktable
    # tigervnc

    # Web
    chromium
    qutebrowser
    # nur.repos.sikmir.qutebrowser-bin

    # LaTeX
    (texlive.combine { inherit (texlive) scheme-medium titlesec; })

    # Dev
    docker-compose
    clang-tools
    # gradle2nix
    morph
    nodejs
    insomnia
    postman
    postgresql_11
    adoptopenjdk-bin
    #jetbrains.idea-community
    jetbrains.idea-ultimate
    mongodb
    mongodb-compass
    robo3t
    dbeaver
    gcc
    go
    gopls
    gotools
    gocode
    godef
    protobuf
    grpc
    (python3.withPackages
      (pp: with pp; [ pylint jedi flake8 autopep8 pygments hvac ]))
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
