{
  inputs,
  lib,
  config,
  ...
}: {
  imports = with inputs; [
    nur.modules.homeManager.default
    sops-nix.homeManagerModules.sops
    stylix.homeManagerModules.stylix
  ];

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    username = "anton";
  };

  programs.home-manager.enable = true;
}
