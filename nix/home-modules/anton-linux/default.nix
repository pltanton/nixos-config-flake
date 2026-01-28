{inputs, lib, ...}: {
  imports = with inputs; [
    self.homeModules.common
    self.homeModules.backgrounds

    self.nixosModules.sops

    # catppuccin.homeModules.catppuccin

    ddcsync.homeManagerModules.default
    autobrowser.homeModules.default

    spicetify-nix.homeManagerModules.spicetify

    ./hyprland
    ./rofi
    ./waybar
    ./autobrowser.nix
    ./cliphist.nix
    ./direnv.nix
    ./ghostty.nix
    ./gpg-agent.nix
    ./home-packages.nix
    ./index.nix
    ./java.nix
    ./keyring.nix
    ./npm.nix
    ./portals.nix
    ./python.nix
    ./services.nix
    ./spotify.nix
    ./ssh-agent.nix
    ./stylix.nix
    ./swaync.nix
    ./swayosd.nix
    ./vscode.nix
    ./xdg.nix
    ./zed.nix
  ];

  nixpkgs.overlays = with inputs; [
    ddcsync.overlays.default
    autobrowser.overlays.default
    # inputs.hyprpanel.overlay
  ];

  sops = {
    scope = "anton";
    defaultSopsFile = lib.mkForce ../anton/secrets.yaml;
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };
}
