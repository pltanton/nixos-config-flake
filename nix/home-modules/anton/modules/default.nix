{inputs, ...}: {
  # imports = inputs.self.lib.modulesDir ./.;
  imports = [
    ./autobrowser.nix
    ./go.nix
    ./nh.nix
    ./shell.nix
    ./theme.nix
    ./cliphist.nix
    ./gpg-agent.nix
    ./npm.nix
    ./ssh-agent.nix
    ./vscode.nix
    ./home-packages.nix
    ./nvim
    ./stylix.nix
    ./waybar
    ./direnv.nix
    ./hyprland
    ./portals.nix
    ./swaync
    ./xdg.nix
    ./firefox.nix
    ./index.nix
    ./python.nix
    ./swayosd.nix
    ./zed.nix
    ./ghostty.nix
    ./java.nix
    ./rofi
    ./syncthing.nix
    ./git.nix
    ./keyring.nix
    ./services.nix
    ./taskwarrion.nix
  ];
}
