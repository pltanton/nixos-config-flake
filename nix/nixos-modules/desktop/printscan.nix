{
  pkgs,
  config,
  lib,
  ...
}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.epson-escpr2 pkgs.cups-filters pkgs.epson-escpr];
  };

  # hardware.printers = {
  #   ensurePrinters = [
  #     {
  #       name = "L3256";
  #       location = "Home";
  #       deviceUri = "ipp://192.168.0.102/ipp/print";
  #       model = "everywhere";
  #     }
  #   ];
  #   ensureDefaultPrinter = "Dell_1250c";
  # };

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.epkowa
      pkgs.sane-airscan
    ];
  };

  services.udev.packages = [pkgs.sane-airscan];

  environment.systemPackages =
    lib.mkIf config.services.printing.enable [pkgs.system-config-printer];
}
