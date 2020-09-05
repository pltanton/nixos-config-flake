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

  sublime-music = super.callPackage ./pkgs/sublime-music.nix {};
}
