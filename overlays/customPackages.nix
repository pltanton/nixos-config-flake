self: super: rec {
  my-rapid-photo-downloader =
    super.callPackage ./pkgs/my-rapid-photo-downloader.nix { };
  bitwarden-rofi = super.callPackage ./pkgs/bitwarden-rofi { };
  texlab = super.callPackage ./pkgs/texlab.nix { };
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
  pam-python = super.callPackage ./pkgs/pam-python.nix { };

  # fido2luks = import ./pkgs/fido2luks.nix super;

  swaylock-effects = super.swaylock-effects.overrideAttrs (oldAttrs: rec {
    version = "v1.6-3";

    src = super.fetchFromGitHub {
      owner = "mortie";
      repo = "swaylock-effects";
      rev = version;
      sha256 = "162aic40dfvlrz40zbzmhcmggihcdymxrfljxb7j7i5qy38iflpg";
    };
  });

  sublime-music = super.callPackage ./pkgs/sublime-music.nix { };

  # aws-sam-translator-fresh = super.aws-sam-translator.overridePythonAttrs
  #   (oldAttrs: rec {
  #     version = "1.30.0";
  #     src = super.fetchFromGitHub {
  #       owner = "aws";
  #       repo = "aws-sam-translator";
  #       rev = "v1.30.0";
  #       sha256 = "0000000000000000000000000000000000000000000000000000";
  #     };
  #   });
  # aws-sam-cli-fresh = super.aws-sam-cli.overridePythonAttrs (oldAttrs: rec {
  #   version = "1.11.0";
  #   propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [
  #     aws-sam-translator-fresh
  #   ];
  #   src = super.fetchFromGitHub {
  #     owner = "aws";
  #     repo = "aws-sam-cli";
  #     rev = "v1.11.0";
  #     # pname = "aws-sam-cli";
  #     # version = "1.11.0";
  #     sha256 = "1qk4zsrnvhn673arfmc8kg1yrfanv1wvy8i0nfsfkzav0r10lisz";
  #   };
  # });
}
