{
  pkgs,
  config,
  ...
}: {
  sops.secrets."gitea-actions" = {
    mode = "0444";
  };

  services.gitea-actions-runner = {
    instances = {
      act = {
        enable = true;
        url = "https://gitea.kaliwe.ru";
        tokenFile = config.sops.secrets.gitea-actions.path;
        name = "home-server";
        labels = [
          "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        ];
      };
    };
  };
}
