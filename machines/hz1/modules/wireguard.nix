{ config, pkgs, ... }:

{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.10.10.1/24" ];
      listenPort = 51820;
      privateKeyFile = "/root/nixos/wgkey";
      peers = [
        {
          allowedIPs = [ "10.10.10.2/32" ];
          publicKey = "eP0Qq+/TywzMRY8u3A72G4wlyIV3cQDcsNJvb1v/snY=";
        }
        {
          allowedIPs = [ "10.10.10.3/32" ];
          publicKey = "1ZtJv1KXYPlRCo4inWTwe1vyJ2sPGk+vhnj3trhygkI=";
        }
        {
          allowedIPs = [ "10.10.10.4/32" ];
          publicKey = "4yVaxHSb1x3jKVhP+tZaQVvePkI9gHh/M6O8AMj8ihw=";
        }
        {
          allowedIPs = [ "10.10.10.5/32" ];
          publicKey = "7wu2pAr5uZF5v+TyXW2Ab5PWsVJ0BPhdBjNGE4TvoCQ=";
        }
        {
          allowedIPs = [ "10.10.10.6/32" ]; # Ilya
          publicKey = "JTWiWKr4LkKAsfKum/ufYkw/H+hsvTmrR8biMS1R5mk=";
        }
      ];
    };
  };
}
