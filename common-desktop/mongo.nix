{pkgs, ...}: {
  services.mongodb = {
    enable = true;
    dbpath = "/home/common/db/mongodb";
  };
}
