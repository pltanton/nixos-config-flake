{ pkgs, ... }: {
  services.mongodb = {
    enable = false;
    dbpath = "/home/common/db/mongodb";
    bind_ip = "0.0.0.0";
  };
}
