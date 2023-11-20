{ options, config, pkgs, lib, inputs, ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)));

  networking.hostName = "thinkpad-x1-gen9";

  system.stateVersion = "22.05"; # Did you read the comment?

  # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.keyFile = "/home/anton/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.generateKey = true;


  nixpkgs.config.permittedInsecurePackages = [ "electron-24.8.6" ];
}
