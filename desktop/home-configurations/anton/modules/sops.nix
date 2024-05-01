{ pkgs, ... }: {
  sops = {
    age.sshKeyPaths = [ "/home/anton/.ssh/id_ed25519" ];
    defaultSopsFile = ./anton/secrets/secrets.yaml;
  };
}
