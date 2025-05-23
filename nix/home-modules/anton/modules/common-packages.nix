{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    nixd # A language server for Nix.
    alejandra # A Nix code formatter.
  ];
}
