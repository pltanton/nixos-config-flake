{inputs, ...}: {
  imports = with inputs; [
    self.homeModules.common
    lazyvim.homeManagerModules.default

    ./modules/common-packages.nix
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/gpg-agent.nix
    ./modules/nh.nix
    ./modules/nix.nix
    ./modules/shell.nix
    ./modules/ssh.nix
    ./modules/stylix.nix
    ./modules/thunderbird.nix
    ./modules/vim.nix
    ./modules/yubikey.nix
    ./modules/zellij.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
