{ pkgs, config, inputs, nur, ... }:

let doomLocalPrivateDir = ".doom.d";
in {
  home.file."${doomLocalPrivateDir}".source = pkgs.linkFarm "doom.d" [
    # straight needs a (possibly empty) `config.el` file to build
    {
      name = "config.el";
      path = ./doom.d/config.el;
    }
  ];

  home.packages = with pkgs; [
    graphviz # org-roam graph vizualization
    binutils
    gnutls
    direnv
    ripgrep
    fd
    hunspell
    hunspellDicts.en-us
    hunspellDicts.ru-ru
    hunspellDicts.en-gb-large
    editorconfig-core-c
    hlint
    cabal-install
    shellcheck
    pipenv
    sqls
    gopls
  ];

  # home.file.".doom.d/themes/catppuccin-theme.el".text =
  #   builtins.readFile "${inputs.emacs-catppuccin}/catppuccin-theme.el";

  programs.doom-emacs = {
    enable = true;
    emacsPackage = pkgs.emacsPgtk;
    doomPrivateDir = pkgs.linkFarm "my-doom-packages" [
      {
        name = "config.el";
        path = ./doom.d/config.el;
      }
      {
        name = "init.el";
        path = ./doom.d/init.el;
      }
    ];

    doomPackageDir = pkgs.linkFarm "my-doom-packages" [
      # straight needs a (possibly empty) `config.el` file to build
      {
        name = "config.el";
        path = pkgs.emptyFile;
      }
      {
        name = "init.el";
        path = ./doom.d/init.el;
      }
      {
        name = "packages.el";
        path = ./doom.d/packages.el;
      }
    ];
  };
}
