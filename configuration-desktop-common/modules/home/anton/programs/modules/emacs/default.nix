{ pkgs, config, inputs, nur, ... }:

let
  update-doom = "${pkgs.writeShellScript "doom-change" ''
    export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
    export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
    if [ ! -d "$DOOMLOCALDIR" ]; then
      ${config.xdg.configHome}/emacs/bin/doom -y install
    else
      ${config.xdg.configHome}/emacs/bin/doom -y sync -u
    fi
  ''}";
in {
  home.packages = with pkgs; [
    # emacsPgtkGcc
    emacs
    emacs-all-the-icons-fonts

    graphviz # org-roam graph vizualization

    binutils
    gnutls
    direnv
    (ripgrep.override { withPCRE2 = true; })
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
  ];

  home = {
    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom-config";
      DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "doom-config" = {
        source = ./doom.d;
        # onChange = update-doom;
      };
      "emacs" = {
        source = inputs.doom-emacs;
        onChange = update-doom;
      };
    };
  };
}
