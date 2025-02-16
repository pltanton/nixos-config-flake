{inputs, ...}: {
  imports = with inputs; [
    self.homeModules.common
    self.homeModules.backgrounds

    self.nixosModules.sops

    anyrun.homeManagerModules.default
    catppuccin.homeManagerModules.catppuccin

    ddcsync.homeManagerModules.default
    autobrowser.homeModules.default

    (import ./modules)
  ];

  nixpkgs.overlays = with inputs; [
    ddcsync.overlays.default
    autobrowser.overlays.default
    # dbeaver.overlays.default
  ];
  nixpkgs.config.allowUnfree = true;

  sops = {
    scope = "anton";
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };
}
