{inputs, ...}: {
  imports = with inputs; [
    self.homeModules.common
    self.homeModules.backgrounds

    self.nixosModules.sops

    anyrun.homeManagerModules.default
    catppuccin.homeManagerModules.catppuccin

    ddcsync.homeManagerModules.default
    autobrowser.homeModules.default

    hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
    spicetify-nix.homeManagerModules.spicetify

    (import ./modules)
  ];

  nixpkgs.overlays = with inputs; [
    ddcsync.overlays.default
    autobrowser.overlays.default
    inputs.hyprpanel.overlay
  ];
  nixpkgs.config.allowUnfree = true;

  sops = {
    scope = "anton";
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };
}
