{ pkgs, lib, ... }: {
  programs.nix-ld.enable = true;
  # environment.sessionVariables = rec {
  # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
  # LD_LIBRARY_PATH = (pkgs.hiPrio "\${NIX_LD_LIBRARY_PATH}");
  # NIX_LD = pkgs.binutils.dynamicLinker;
  # };
}
