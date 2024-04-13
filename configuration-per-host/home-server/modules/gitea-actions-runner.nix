{pkgs, secrets, config, ...}:
{

  sops.secrets."gitea-actions" = {
    mode = "0444";
   };

  services.gitea-actions-runner = {
    instances = {
      act = {
        enable = true;
        url = "https://gitea.kaliwe.ru";
        tokenFile = "/run/secrets/gitea-actions";
        name = "home-server";
        labels = [
          "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        ];
      };
    };
  };
}