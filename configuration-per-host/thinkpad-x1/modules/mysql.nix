{ pkgs, ... }: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  environment.systemPackages = [ pkgs.mariadb-client ];
}
