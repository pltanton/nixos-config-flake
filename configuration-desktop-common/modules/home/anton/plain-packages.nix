{ pkgs, lib, fetchPypi, inputs, ... }: {
  home.packages = with pkgs;
    lib.mkIf true [
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
      pulseaudio
      shared-mime-info
      pantheon.elementary-files
      pcmanfm

      # Fonts
      font-awesome_5
      emojione
      iosevka
      inter
      #nerdfonts

      #############
      # User apps #
      #############
      # CLI utils
      nix-prefetch-github
      gitAndTools.gh
      libnotify
      xdg-utils

      ffmpeg
      curlie # replacement for httpie
      bat # cat but with highlights
      exa # modern ls
      duf # beauty df
      tldr # cheatsheets for cli
      procs # modern ps
      jq
      bitwarden-cli
      htop
      btop
      inetutils
      nfs-utils
      ddcutil # utility to control external monitor brightness

      tmux
      unzip
      unrar
      wget
      tree

      plantuml

      # GUI
      libreoffice
      evince
      imv
      gthumb
      gnome-photos
      gimp
      # (gimp-with-plugins.override {
      #   plugins = with gimpPlugins; [ resynthesizer ];
      # })
      mpv
      tdesktop
      vlc
      xsane

      slack

      nix-alien
      nix-index
      nix-index-update

      inputs.activate-linux.defaultPackage.x86_64-linux
      master.zoom-us

      master.thunderbird-wayland
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
      docker-compose
      clang-tools
      kubectl
      kubectx
      sqlite
      postgresql_13
      coreutils
      grpc
      evans # grpc client
      graphviz
      nodejs
      # jetbrains.idea-ultimate
      jetbrains.idea-community
      # jetbrains.datagrip
      # android-studio
      mongodb
      dbeaver
      beekeeper-studio
      gcc
      black # Python code formatter
      python-language-server
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

      # stable.awscli2
      # stable.aws-sam-cli
    ];
}
