{ inputs, ... }: {
  imports = with inputs;[
    sops-nix.nixosModules.sops
  ];

  sops.age.keyFile = "/home/anton/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.generateKey = true;
}
