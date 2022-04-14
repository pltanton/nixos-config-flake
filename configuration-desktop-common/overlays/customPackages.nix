inputs: self: super: rec {
  my-rapid-photo-downloader =
    super.callPackage ./pkgs/my-rapid-photo-downloader.nix { };
  bitwarden-rofi = super.callPackage ./pkgs/bitwarden-rofi { };
  # texlab = super.callPackage ./pkgs/texlab.nix { };
  fuzzylite = super.callPackage ./pkgs/fuzzylite.nix { };
  vcmi = super.callPackage ./pkgs/vcmi.nix { };
  keepmenu = super.callPackage ./pkgs/keepmenu.nix { };
  oh-my-zsh = import ./pkgs/oh-my-zsh.nix super;
  phockup = import ./pkgs/phockup.nix super;
  myxkbutil = super.callPackage ./pkgs/myxkbutil/default.nix { };
  ranger_git = super.ranger.overrideAttrs (oldAttrs: rec {
    src = super.fetchFromGitHub {
      owner = "ranger";
      repo = "ranger";
      rev = "bb277d1eff052e2478fb8c132bc42793ce91b870";
      sha256 = "0mvddxvwbzqxyjpwzlz6xhq9kykagfqknwzg0pc7ch5sfi3q6k5z";
    };
    propagatedBuildInputs = oldAttrs.propagatedBuildInputs
      ++ [ super.pythonPackages.pillow ];
  });

  howdy = super.callPackage ./pkgs/howdy { };
  ir-toggle = super.callPackage ./pkgs/ir-toggle { };
  # pam-python = super.callPackage ./pkgs/pam-python.nix { };

  # fido2luks = import ./pkgs/fido2luks.nix super;

  swaylock-effects = super.swaylock-effects.overrideAttrs (oldAttrs: rec {
    version = inputs.swaylock-effects-src.rev;

    src = inputs.swaylock-effects-src;
  });

  sublime-music = super.callPackage ./pkgs/sublime-music.nix { };

  brother-dcp-t710 =
    (super.callPackage ./pkgs/brother-dcp-t710w.nix { }).cupswrapper;

  brlaser_fork = super.brlaser.overrideAttrs (oldAttrs: rec {
    version = "master";
    src = super.fetchFromGitHub {
      owner = "QORTEC";
      repo = "brlaser";
      rev = "d3b07f150e3b5e41013e88abe53ee443598f54dc";
      sha256 = "05lpr4ny2p04p0sz3c9ki2zywvynwkimnwrk4in0kybvhk7djq9q";
    };
  });

  zoom = super.zoom-us.overrideAttrs (old: {
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
    '';
  });
}
