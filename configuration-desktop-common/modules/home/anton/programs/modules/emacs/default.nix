{ pkgs, config, inputs, nur, ... }:

let
  update-doom = "${pkgs.writeShellScript "doom-change" ''
    export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
    export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
    export DDOOMPROFILELOADFILE="${config.home.sessionVariables.DOOMPROFILELOADFILE}"
    if [ ! -d "$DOOMLOCALDIR" ]; then
      ${config.xdg.configHome}/emacs/bin/doom install
    else
      ${config.xdg.configHome}/emacs/bin/doom sync -u
    fi
  ''}";

  # emacsPackage = (pkgs.emacs.override {
  # withPgtk = true;
  # });
  # emacsPackage = pkgs.emacsPgtk;
  # emacsPackage = pkgs.emacsng;
  # emacsPackage = pkgs.emacs;
in {
  home.packages = with pkgs; [
    # emacsPgtkNativeComp
    # emacsPgtk
    # emacsGitNativeComp
    # emacsPackage

    # emacs-all-the-icons-fonts
    # font-awesome_5

    graphviz # org-roam graph vizualization

    binutils
    gnutls
    direnv
    ripgrep
    # (ripgrep.override { withPCRE2 = true; })
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

    # LSPs
    sqls
    gopls
  ];

  home.file.".doom.d/themes/catppuccin-theme.el".text =
    builtins.readFile "${inputs.emacs-catppuccin}/catppuccin-theme.el";

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacsPgtk;
  };

  # services.emacs = {
  #   enable = true;
  #   package = emacsPackage;
  # };

  # home = {
  #   sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  #   sessionVariables = {
  #     DOOMDIR = "${config.xdg.configHome}/doom-config";
  #     DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
  #     DOOMPROFILELOADFILE = "${config.xdg.configHome}/doom-profiles/load.el";
  #   };
  # };

  # xdg = {
  #   enable = true;
  #   configFile = {
  #     "doom-config" = {
  #       source = ./doom.d;
  #       # onChange = update-doom;
  #     };
  #     "emacs" = {
  #       source = inputs.doom-emacs;
  #       onChange = update-doom;
  #     };
  #     # "emacs/profiles" = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/doom-profiles";
  #   };
  # };
}
