{ pkgs, lib, fetchPypi, inputs, ... }: {
  home.packages = with pkgs;
    lib.mkIf true [
      hack-font

      nixfmt
      shfmt

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
      xournal

      # Fonts
      font-awesome
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
      libreoffice
      evince
      imv
      gthumb
      gimp
      # (gimp-with-plugins.override {
      #   plugins = with gimpPlugins; [ resynthesizer ];
      # })
      mpv
      tdesktop
      xsane
      spotify

      slack

      inputs.activate-linux.defaultPackage.x86_64-linux

      thunderbird-wayland
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
      grpcurl # grpc client
      nodejs
      # intellij-idea-ultimate
      # master.jetbrains.idea-community
      # jetbrains.idea-ultimate
      # intellij-idea-community-eap
      # jetbrains.datagrip
      # android-studio
      (stable.jetbrains.idea-ultimate.overrideAttrs (oldAttrs: rec {
        src = fetchurl {
          url = "https://download.jetbrains.com/idea/ideaIU-2022.2.3.tar.gz";
          sha256 = "1cw4c6ai4q9g35nkc19c0allvvlxp216pmlld0bggjffff0xxyg1";
        };
      }))
      # stable.jetbrains.idea-ultimate

      mongodb
      dbeaver
      beekeeper-studio
      gcc
      black # Python code formatter
      (python310.withPackages (pp:
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
          grpcio-tools
          python-lsp-server
          poetry
        ]))
      # python-language-server
      inputs.mach-nix.defaultPackage.x86_64-linux
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc

      nodePackages.yaml-language-server
      nodePackages.prettier
      nodePackages.vue-language-server
      nodePackages.eslint
      gnumake
      zip

      steam-run-native
    ];
}
