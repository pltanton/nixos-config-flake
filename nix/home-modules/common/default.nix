{
  inputs,
  lib,
  config,
  ...
}: {
  imports = with inputs; [
    nur.modules.homeManager.default
    sops-nix.homeManagerModules.sops
    catppuccin.homeModules.catppuccin
    self.homeModules.backgrounds
  ];

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    username = "anton";
  };

  programs.home-manager.enable = true;
}
