{ pkgs, lib, config, ... }:

{
  networking.firewall.allowedTCPPorts =
    lib.mkIf config.services.k3s.enable [ 6443 ];
  environment.systemPackages = lib.mkIf config.services.k3s.enable [ pkgs.k3s ];

  services.k3s.enable = false;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [ ];

}
