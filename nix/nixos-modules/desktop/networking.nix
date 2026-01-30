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
    wireless.iwd.enable = true;
  };
}
