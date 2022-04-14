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

      gnome.gnome-tweaks
      gnome.gnome-shell-extensions

      ffmpegthumbnailer
      pamixer
      paprefs
      pavucontrol
      pulseaudio
      qjackctl
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
      btop
      inetutils
      nfs-utils

      tmux
      unzip
      unrar
      wget
      tree

      plantuml

      # GUI
      libreoffice

      evince
      # stable.zathura
      imv
      gthumb
      gnome-photos
      gimp
      mpv
      master.tdesktop
      vlc
      xsane
      stable.slack
      mattermost-desktop
      spotify
      teams

      stable.thunderbird
      bitwarden
      sidequest
      scrcpy
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
      sqlite
      postgresql_13
      coreutils
      grpc
      evans # grpc client
      graphviz
      nodejs
      insomnia
      postman
      # jetbrains.idea-ultimate
      jetbrains.idea-community
      # jetbrains.datagrip
      # android-studio
      mongodb
      robo3t
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
