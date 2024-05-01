{ inputs, ... }:
{
  imports = with inputs;[
    self.homeModules.common
    self.homeModules.backgrounds

    hyprland.homeManagerModules.default
    hypridle.homeManagerModules.default
    hyprlock.homeManagerModules.default

    nix-doom-emacs.hmModule
    anyrun.homeManagerModules.default

    ddcsync.homeManagerModules.default
    autobrowser.homeModules.default

    {
      nixpkgs.overlays = [
        ddcsync.overlays.default
        autobrowser.overlays.default
        dbeaver.overlays.default
      ];
      nixpkgs.config.allowUnfree = true;
    }

    (import ./modules)
  ];
}
