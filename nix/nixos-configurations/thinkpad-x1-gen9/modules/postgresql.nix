{
  pkgs,
  lib,
  ...
}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
      host  all  all 0.0.0.0/0 md5
    '';
    settings = {
      log_min_messages = "info";
      log_error_verbosity = "default";
    };
  };
  systemd.services.postgresql = {wantedBy = lib.mkForce [];};
}
