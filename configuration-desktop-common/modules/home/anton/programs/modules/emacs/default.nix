{ pkgs, config, inputs, nur, ... }:

let
  DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
  DOOMDIR = "${config.xdg.configHome}/doom";
  DOOMPROFILELOADFILE = "${config.xdg.dataHome}/doom/cache/profile-load.el";
in {

  home.packages = with pkgs; [
    graphviz
    binutils
    gnutls
    direnv
    ripgrep
    fd
    editorconfig-core-c
    hlint
    cabal-install
    shellcheck
    pipenv
    sqls
    gopls

    emacs-all-the-icons-fonts

    hunspell
    hunspellDicts.en-us
    hunspellDicts.ru-ru
    hunspellDicts.en-gb-large
  ];

  home.sessionVariables = { inherit DOOMLOCALDIR DOOMDIR DOOMPROFILELOADFILE; };
  systemd.user.sessionVariables = {
    inherit DOOMLOCALDIR DOOMDIR DOOMPROFILELOADFILE;
  };

  xdg.configFile."doom".source = ./doom.d;
  xdg.dataFile."doom/cache/.keep".text = "";

  xdg.configFile."emacs" = {
    source = pkgs.applyPatches {
      name = "doom-emacs-source";
      src = inputs.doom-emacs;
    };
    force = true;
  };

  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  services.emacs = { enable = true; };
}
