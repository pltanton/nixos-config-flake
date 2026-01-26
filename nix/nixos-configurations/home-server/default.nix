{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    stateVersion = "21.11";
    consts = import ./constants.nix;
  };

  modules = with inputs; [
    self.nixosModules.common
    self.nixosModules.common-ssh-keys

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }

    firefly-iii-boc-fixer.nixosModules.default

    self.nixosModules.sops
    (_: {
      sops = {
        scope = "home-server";
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        age.keyFile = "/var/lib/sops-nix/key.txt";
      };
    })

    (_: {
      nixpkgs.overlays = with inputs; [
        firefly-iii-boc-fixer.overlays.default
      ];
    })

    ./configuration.nix

    (import ./modules)
  ];
}
