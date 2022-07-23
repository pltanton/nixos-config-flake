{ pkgs, ... }: {
  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
  };

  environment.systemPackages = [ pkgs.mariadb-client ];
}
