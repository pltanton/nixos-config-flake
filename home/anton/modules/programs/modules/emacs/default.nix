{ pkgs, config, inputs, ... }:

let
  doom-emacs = pkgs.callPackage inputs.nixDoomEmacs { doomPrivateDir = ./doom.d; };
in {
  home.packages = [ doom-emacs ];

  home.file.".emacs.d/init.el".text = ''
    (load "default.el")
  '';
}
