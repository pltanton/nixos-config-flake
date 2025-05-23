{inputs, ...}: {
  imports = with inputs;
    [
      self.homeModules.common
      self.homeModules.backgrounds

      self.nixosModules.sops

      catppuccin.homeModules.catppuccin

      ddcsync.homeManagerModules.default
      autobrowser.homeModules.default

      hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
      spicetify-nix.homeManagerModules.spicetify
    ]
    ++ inputs.self.lib.modulesDir ./.;

  nixpkgs.overlays = with inputs; [
    ddcsync.overlays.default
    autobrowser.overlays.default
    inputs.hyprpanel.overlay
  ];

  sops = {
    scope = "anton";
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };
}
