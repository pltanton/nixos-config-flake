{ config, pkgs, ... }:

{
  services = {
    taskserver = {
      enable = true;
      listenHost = "::";
      fqdn = "hz1.kaliwe.ru";
      organisations = {
        home = {
          users = [ "anton" ];
        };
      };
    };
  };
}
