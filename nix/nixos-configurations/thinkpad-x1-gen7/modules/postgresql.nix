{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
      host  all  all 0.0.0.0/0 md5
    '';
  };
}
