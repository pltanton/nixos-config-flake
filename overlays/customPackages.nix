self: super:
{
  my-rapid-photo-downloader = super.callPackage ./pkgs/my-rapid-photo-downloader.nix {};
  bitwarden-rofi = super.callPackage ./pkgs/bitwarden-rofi {};
  texlab = super.callPackage ./pkgs/texlab.nix {};
  fuzzylite = super.callPackage ./pkgs/fuzzylite.nix {};
  vcmi = super.callPackage ./pkgs/vcmi.nix {};
  keepmenu = super.callPackage ./pkgs/keepmenu.nix {};
  oh-my-zsh = import ./pkgs/oh-my-zsh.nix super;
  phockup = import ./pkgs/phockup.nix super;
  myxkbutil = super.callPackage ./pkgs/myxkbutil/default.nix {};
  ranger_git = super.ranger.overrideAttrs (oldAttrs: rec {
    src = super.fetchFromGitHub {
      owner = "ranger";
      repo = "ranger";
      rev = "bb277d1eff052e2478fb8c132bc42793ce91b870";
      sha256 = "0mvddxvwbzqxyjpwzlz6xhq9kykagfqknwzg0pc7ch5sfi3q6k5z";
    };
    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++
      [ super.pythonPackages.pillow ];
  });

  # fido2luks = import ./pkgs/fido2luks.nix super;

  # fido2luks-fresh = super.fido2luks.overrideAttrs (old: {
  #   version = "0.2.14";
  #   src = super.fetchFromGitHub {
  #     owner = "shimunn";
  #     repo = super.fido2luks.pname;
  #     rev = "0.2.14";
  #     sha256 = "sha256-AKmMWO0u+en8t9Gc2NsHz5JMYA5HWlNVUlJjphkCZcA=";
  #   };

  #   cargoSha256 = "sha256-tK/Rc02QWq61Q+6kTPqYWlxfIlG6+kIjp1LTIp/7N88=";
  # });

  sublime-music = super.callPackage ./pkgs/sublime-music.nix {};
}
