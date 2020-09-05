{ pkgs, ... }:
let
  gradle2nix = import (fetchTarball {
    url = "https://github.com/tadfisher/gradle2nix/archive/master.tar.gz";
    sha256 = "04skv5nhbqzybxsqp7b7l4s7nl66p8cd92f6czlivwcjnj36lzya";
  }) { pkgs = pkgs; };
in {
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
  };

  services = {
    status-notifier-watcher.enable = true;
    network-manager-applet.enable = true;
    udiskie.enable = true;
    pasystray.enable = true;
    blueman-applet.enable = true;
    unclutter.enable = true;
    gnome-keyring.enable = true;
    nextcloud-client.enable = true;
    mpd.enable = true;
  };

  home.packages = with pkgs; [
    #nerdfonts
    hack-font
    emacs-all-the-icons-fonts

    gnuplot

    nixfmt

    ###################
    # Packages for DE #
    ###################
    arandr
    clipit
    ffmpegthumbnailer
    kbdd
    libnotify
    light
    maim
    networkmanagerapplet
    pamixer
    paprefs
    pavucontrol
    shared_mime_info
    siji
    xbanish
    xclip
    xdotool
    pantheon.elementary-files
    ark
    xkblayout-state
    xorg.xbacklight
    xxkb
    xorg.xkill
    glib

    haskellPackages.greenclip

    # Fonts
    font-awesome_5
    emojione
    iosevka-bin
    #nerdfonts

    #################
    # Look and feel #
    #################
    gnome3.adwaita-icon-theme

    #############
    # User apps #
    #############
    # CLI utils
    fzf
    ansible
    dnsutils
    jq
    #gopass
    bitwarden-cli
    mpc_cli
    ncmpcpp
    htop
    inetutils
    killall
    nfs-utils
    #nodePackages.peerflix
    ispell

    #pass
    (pass.withExtensions (ex: with ex; [ pass-otp ]))
    passff-host

    ranger
    tmux
    unzip
    #vault
    wget
    tree

    # GUI
    syncplay
    sublime-music
    clementine
    xournalpp
    discord
    zoom-us
    transmission-remote-gtk
    transmission-gtk
    (lowPrio kdenlive)
    rapid-photo-downloader
    evince
    gnome3.eog
    gthumb
    gimp
    mpv
    tdesktop
    vlc
    xsane
    slack
    #steam
    bitwarden
    bitwarden-rofi
    sidequest
    scrcpy
    darktable
    caffeine-ng
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
    adoptopenjdk-bin
    jetbrains.idea-community
    jetbrains.idea-ultimate
    dbeaver
    go
    gopls
    protobuf
    grpc
    (python3.withPackages
      (pp: with pp; [ pylint jedi flake8 autopep8 grpcio pygments hvac ]))
    nodePackages.yaml-language-server
    nodePackages.prettier
    nodePackages.vue-language-server
    nodePackages.eslint

  ];
}
