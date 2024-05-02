{
  config,
  pkgs,
  ...
}: {
  sops.secrets."wireguard/server-key" = {};

  networking = {
    firewall.enable = false;
    firewall = {allowedUDPPorts = [51820];};
    nat.enable = true;
    nat.internalInterfaces = ["wg-sprintbox"];
    nat.externalInterface = "ens3";

    wireguard.interfaces = {
      wg-sprintbox = {
        ips = ["10.10.10.1/24"];
        listenPort = 51820;
        privateKeyFile = "/run/secrets/wireguard/server-key";
        peers = [
          {
            allowedIPs = ["10.10.10.2/32"];
            publicKey = "W1a3Fdij/Sk/GDMOl37msCzVjJHcKM2qcdp2dgliVSI=";
          }
          {
            allowedIPs = ["10.10.10.201/32"]; # Anton phone
            publicKey = "RGG0VTALtT0FfYFpuAoPBj8mspaD1YfZP51xbIWhFXE=";
          }
          {
            allowedIPs = ["10.10.10.204/32"]; # Anton pc
            publicKey = "ePvGkH8PBne/zc7poF53RiPTs9dZIWMdF+WVX/kMLh4=";
          }
          {
            allowedIPs = ["10.10.10.202/32"]; # Julia phone
            publicKey = "w6OgTrYLTjvjo1PekDWn7OlNBg9tU+tDtzCjrc9MGl4=";
          }
          {
            allowedIPs = ["10.10.10.203/32"]; # Julia pc
            publicKey = "i4TEdsRr75rjqNOs5qroTGBmA/J0dmj7CAfEEle5X30=";
          }
        ];

        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s10.10.10.0/24 -o ens3 -j MASQUERADE
        '';

        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s10.10.10.0/24 -o ens3 -j MASQUERADE
        '';
      };
    };
  };
}
