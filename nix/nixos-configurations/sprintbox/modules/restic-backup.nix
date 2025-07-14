{config, ...}: {
  sops.secrets."restic/repo/home/path" = {};
  sops.secrets."restic/repo/home/password" = {};

  services.restic.backups = {
    home = {
      initialize = true;
      paths = [
        config.services.postgresql.dataDir
      ];

      repositoryFile = config.sops.secrets."restic/repo/home/path".path;
      passwordFile = config.sops.secrets."restic/repo/home/password".path;

      timerConfig = {
        OnCalendar = "00:05";
      };
    };
  };
}
