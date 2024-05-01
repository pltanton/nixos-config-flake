{ pkgs, ... }: {
  sops = {
    age.sshKeyPaths = [ "/home/anton/.ssh/id_ed25519" ];
    defaultSopsFile = ../secrets/secrets.yaml;
  };
}
