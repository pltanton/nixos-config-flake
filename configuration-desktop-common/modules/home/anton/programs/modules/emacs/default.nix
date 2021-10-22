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
  # programs.doom-emacs = {
  #   enable = true;
  #   emacsPackage = pkgs.emacsPgtk;
  #   # emacsPackage = pkgs.emacsGcc;
  #   # emacsPackage = pkgs.emacs;
  #   doomPrivateDir = ./doom.d;

  #   emacsPackagesOverlay = self: super:
  #     {
  #       # caddyfile-mode = super.caddyfile-mode.overrideAttrs
  #       #   (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });
  #     };
  # };

  # home.packages = with pkgs; [
  #   ripgrep
  #   hunspell
  #   hunspellDicts.en-us
  #   hunspellDicts.en-gb-large
  #   hunspellDicts.ru-ru
  # ];

  home.packages = with pkgs; [
    emacsPgtkGcc
    # emacsGcc
    # emacsPgtk
    # emacs
    emacs-all-the-icons-fonts
    # nur.repos.metadark.emacs-pgtk-nativecomp
    # emacs

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

    gocode
    gomodifytags
    gotests
    gore
    goimports

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
        onChange = update-doom;
      };
      "emacs" = {
        source = inputs.doom-emacs;
        onChange = update-doom;
      };
    };
  };
}
