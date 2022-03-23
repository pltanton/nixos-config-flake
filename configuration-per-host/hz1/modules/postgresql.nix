{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.pgloader ];
  services = {
    postgresql = {
      enable = true;
      dataDir = "/var/lib/postgresql/11.1";
      package = pkgs.postgresql_11;
    };
  };
}
