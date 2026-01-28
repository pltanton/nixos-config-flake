{lib, ...}: {
  services.resolved = {
    enable = false;
    settings = {
      Resolve = {
        DNS = "10.100.0.1";
        Domains = "home";
        DNSSEC = "false";
      };
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hosts = {};
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    firewall.enable = false;
  };
}
