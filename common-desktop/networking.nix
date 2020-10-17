{ pkgs, ... }: {
  networking = {
    #nameservers = [ "8.8.8.8" ];
    hosts = { };
    networkmanager.enable = true;
  };
}
