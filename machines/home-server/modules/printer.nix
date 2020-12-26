{ config, pkgs, ... }:
let secrets = import ../secrets.nix;
in {
  networking.firewall.connectionTrackingModules = [ "sane" ];
  services = {
    avahi = {
      enable = true;
      publish.enable = true;
      publish.userServices = true;
    };

    printing = {
      enable = true;
      listenAddresses = [
        "*:631"
      ]; # Not 100% sure this is needed and you might want to restrict to the local network
      defaultShared = true; # If you want
      drivers = [ pkgs.gutenprint ];
    };

    saned = {
      enable = true;
      extraConfig = ''
        192.168.0.0/16
        connect_timeout = 3
      '';
    };
  };

  hardware.sane = { enable = true; };

  users.users.nextcloud = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ secrets.homeAssistantSshPub ];
    extraGroups = [ "scanner" "lp" ];
  };

  networking.firewall.allowedUDPPorts = [ 631 ];
  networking.firewall.allowedTCPPorts = [ 631 ];
}
