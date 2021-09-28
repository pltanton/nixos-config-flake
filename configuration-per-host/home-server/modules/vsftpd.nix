{ config, pkgs, ... }:
{
  services.vsftpd = {
    enable = true;
    localUsers = true;
    userlist = [ "publicstore" "privatestore" ];
    userlistEnable = true;
  };
}
