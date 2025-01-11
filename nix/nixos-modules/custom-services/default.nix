{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.ccsync;

  defaultSettings = {
    CONTAINER_ORIGIN = "http://localhost:${toString config.services.taskchampion-sync-server.port}";
  };
in {
  options.services.ccsync = {
    enable = lib.mkEnableOption "Service to synchronize taskwarrior 3 with mobile app";

    environmentFile = lib.mkOption {
      default = null;
      type = with lib.types; nullOr path;
    };

    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = defaultSettings;
      example = {
      };
    };
  };
  config = let
    mergedConfig = defaultSettings // cfg.settings;
  in
    lib.mkIf cfg.enable {
      systemd.services.ccsync = {
        wantedBy = ["multi-user.target"];
        after = ["network.target"];
        description = "CCSync sync server for taskwarroir 3";
        environment = mergedConfig;
        serviceConfig =
          {
            DynamicUser = true;
            ExecStart = "${pkgs.ccsync-backend}/bin/ccsync_backend";
            Restart = "on-failure";
            RestartSec = "5s";
          }
          // lib.optionalAttrs (cfg.environmentFile != null) {EnvironmentFile = cfg.environmentFile;};
      };
    };
}
