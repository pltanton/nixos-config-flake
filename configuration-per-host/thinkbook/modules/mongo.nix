{ pkgs, ... }: {
  services.mongodb = {
    enable = true;
    dbpath = "/home/common/db/mongodb";
    bind_ip = "0.0.0.0";
  };
}
