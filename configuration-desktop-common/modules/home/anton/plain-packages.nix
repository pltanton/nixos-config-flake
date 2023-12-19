{ pkgs, lib, fetchPypi, inputs, ... }:
let
  enlargeCursorForDesktopEntry = package:
    (package.overrideAttrs (e: rec {
      # Add arguments to the .desktop entry
      desktopItem =
        e.desktopItem.override (d: { exec = "env XCURSOR_SIZE=64 ${d.exec}"; });

      # Update the install script to use the new .desktop entry
      installPhase =
        builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ]
        e.installPhase;
    }));
in {
  home.packages = with pkgs;
    lib.mkIf true [
      hack-font
      monaspace

      nixfmt
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
      emojione
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
      unrar
      wget
      tree

      plantuml

      # GUI
      # wpsoffice
      onlyoffice-bin
      libreoffice

      logseq
      anki-bin

      evince
      imv
      gthumb
      gimp
      # (gimp-with-plugins.override {
      #   plugins = with gimpPlugins; [ resynthesizer ];
      # })
      mpv
      telegram-desktop
      xsane
      simple-scan
      spotify

      slack

      inputs.activate-linux.defaultPackage.x86_64-linux

      thunderbird
      bitwarden
      sidequest
      scrcpy

      # Web
      chromium
      # nur.repos.sikmir.qutebrowser-bin
      # qutebrowser

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
      # nur.repos.utybo.jetbrains.idea-community
      master.jetbrains-toolbox
      master.jetbrains.pycharm-professional
      # (enlargeCursorForDesktopEntry master.jetbrains.idea-ultimate)
      # (enlargeCursorForDesktopEntry master.jetbrains.idea-community)
      master.jetbrains.idea-community

      dbeaver
      beekeeper-studio
      gcc
      inputs.mach-nix.defaultPackage.x86_64-linux
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

      # ZMK
      python311Packages.west
    ];
}
