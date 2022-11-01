{ pkgs, lib, ... }: {
  services.resolved = {
    enable = true;
    extraConfig = (lib.generators.toINI { } {
      Resolve = {
        DNS = "10.100.0.1";
        Domains = "home";
        DNSSEC = "false";
      };
    });
  };
  networking = {
    hosts = { };
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };
}
