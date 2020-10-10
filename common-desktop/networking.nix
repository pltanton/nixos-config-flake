{ pkgs, ... }: {
  networking = {
    #nameservers = [ "8.8.8.8" ];
    hostName = "nixos";
    hosts = { };
    networkmanager.enable = true;
  };
}
