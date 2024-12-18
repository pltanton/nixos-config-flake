{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    stateVersion = "21.11";
  };

  modules = with inputs; [
    self.nixosModules.common

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

    (import ./packages)
    (import ./modules)
  ];
}
