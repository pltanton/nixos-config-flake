{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    stateVersion = "21.11";
  };

  modules = with inputs; [
    self.nixosModules.common
    self.nixosModules.common-ssh-keys

    self.nixosModules.sops
    (_: {
      sops = {
        scope = "sprintbox";
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        age.keyFile = "/var/lib/sops-nix/key.txt";
      };
    })

    ./configuration.nix
    (import ./modules)
  ];
}
