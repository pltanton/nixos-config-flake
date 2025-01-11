{config, ...}: let
  syncthingCfg = config.services.syncthing;
  pgBackupDir = config.services.postgresqlBackup.location;

  backupFileLocation = "${pgBackupDir}/all.sql.gz";
  backupDir = "${syncthingCfg.dataDir}/backup-sprintbox";
  devices = [];
in {
  services.postgresqlBackup = {enable = true;};

  systemd.services."postgresqlBackup".serviceConfig = {
    ExecStartPost = ''
      chmod g+rw ${backupFileLocation} && \
      chgrp ${syncthingCfg.group} ${backupFileLocation} && \
      cp ${backupFileLocation} ${backupDir}/all.sql.gz && \
      echo "DB dump moved to the backup directory"'
    '';
  };

  services.syncthing = {
    enable = true;
    settings.folders = {
      "${backupDir}" = let
        folderId = "db-dump";
      in {
        id = folderId;
        label = folderId;
        rescanIntervalS = 300;
        inherit devices;
        type = "sendonly";
        versioning = {
          type = "simple";
          params.keep = "6";
        };
      };
    };
    extraFlags = ["--no-upgrade" "--no-restart"];
  };

  systemd.tmpfiles.rules = [
    "z ${syncthingCfg.dataDir} 0750 ${syncthingCfg.user} ${syncthingCfg.group}"
    "d ${backupDir} 0775 ${syncthingCfg.user} ${syncthingCfg.group}"
  ];

  users.users = {
    postgres.extraGroups = [syncthingCfg.group];
  };
}
