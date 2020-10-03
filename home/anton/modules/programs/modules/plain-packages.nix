{ pkgs, ... }:
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
    wdisplays
    wl-clipboard

    ffmpegthumbnailer
    libnotify
    networkmanagerapplet
    pamixer
    paprefs
    pavucontrol
    shared_mime_info
    xbanish
    pantheon.elementary-files
    xorg.xkill
    glib

    haskellPackages.greenclip

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
    wget
    tree

    # GUI
    xournalpp
    discord
    zoom-us
    transmission-remote-gtk
    transmission-gtk
    (lowPrio kdenlive)
    rapid-photo-downloader
    evince
    gnome3.eog
    gnome3.geary
    gthumb
    gimp
    mpv
    tdesktop
    vlc
    xsane
    slack
    spotify
    #steam
    bitwarden
    bitwarden-rofi
    sidequest
    scrcpy
    darktable
    tigervnc

    # Web
    chromium
    qutebrowser

    # LaTeX
    (texlive.combine { inherit (texlive) scheme-medium titlesec; })

    # Dev
    clang-tools
    gradle2nix
    morph
    nodejs
    insomnia
    postman
    postgresql_11
    adoptopenjdk-bin
    #jetbrains.idea-community
    jetbrains.idea-ultimate
    dbeaver
    go
    gopls
    protobuf
    grpc
    (python3.withPackages
      (pp: with pp; [ pylint jedi flake8 autopep8 pygments hvac ]))
    nodePackages.yaml-language-server
    nodePackages.prettier
    nodePackages.vue-language-server
    nodePackages.eslint
    gnumake

    awscli2
    aws-sam-cli

  ];
}
