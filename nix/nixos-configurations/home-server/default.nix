{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    stateVersion = "21.11";
  };

  modules = with inputs; [
    self.nixosModules.common

    self.nixosModules.sops
    ({...}: {
      sops = {
        scope = "home-server";
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        age.keyFile = "/var/lib/sops-nix/key.txt";
      };
    })

    ./configuration.nix

    (import ./packages)
    (import ./modules)
  ];
}
