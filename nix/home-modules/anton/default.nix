{inputs, ...}: {
  imports = with inputs; [
    self.homeModules.common

    ./modules/common-packages.nix
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/gpg-agent.nix
    ./modules/helix.nix
    ./modules/nh.nix
    ./modules/nix.nix
    ./modules/secrets.nix
    ./modules/shell.nix
    ./modules/ssh.nix
    ./modules/theme.nix
    ./modules/thunderbird.nix
    ./modules/yubikey.nix
    ./modules/zellij.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
