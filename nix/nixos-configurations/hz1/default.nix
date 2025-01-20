{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    stateVersion = "20.09";
  };

  modules = with inputs; [
    self.nixosModules.common
    self.nixosModules.custom-services

    self.nixosModules.sops
    (_: {
      sops = {
        scope = "hz1";
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        age.keyFile = "/var/lib/sops-nix/key.txt";
      };
    })

    ./configuration.nix
    (import ./modules)
  ];
}
