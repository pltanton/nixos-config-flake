{
  inputs,
  lib,
  ...
}: {
  imports = with inputs; [
    self.homeModules.common
    self.homeModules.backgrounds
    zen-browser.homeModules.beta

    self.nixosModules.sops

    # catppuccin.homeModules.catppuccin

    ddcsync.homeManagerModules.default
    autobrowser.homeModules.default

    spicetify-nix.homeManagerModules.spicetify
    niri.homeModules.niri
    danksearch.homeModules.dsearch

    ./niri
    ./dank-material-shell.nix
    ./danksearch.nix
    ./codex.nix
    ./autobrowser.nix
    ./cliphist.nix
    ./direnv.nix
    ./ghostty.nix
    ./gpg-agent.nix
    ./home-packages.nix
    ./index.nix
    ./nirius.nix
    ./java.nix
    ./matugen.nix
    ./keyring.nix
    ./npm.nix
    ./ollama.nix
    ./portals.nix
    ./python.nix
    ./session-targets.nix
    ./services.nix
    ./scripts.nix
    ./spotify.nix
    ./ssh-agent.nix
    ./theme.nix
    ./swaync.nix
    ./swayosd.nix
    ./vscode.nix
    ./xdg.nix
    ./zed.nix
    ./zen.nix
  ];

  nixpkgs.overlays = with inputs; [
    ddcsync.overlays.default
    autobrowser.overlays.default
    # inputs.hyprpanel.overlay
  ];

  sops = {
    scope = "anton";
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };
}
