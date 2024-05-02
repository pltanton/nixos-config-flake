{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    stateVersion = "20.09";
  };

  modules = with inputs; [
    self.nixosModules.common

    self.nixosModules.sops
    ({...}: {
      sops = {
        scope = "hz1";
        age.generateKey = true;
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        age.keyFile = "/var/lib/sops-nix/key.txt";
      };
    })

    ./configuration.nix
    (import ./modules)
  ];
}
