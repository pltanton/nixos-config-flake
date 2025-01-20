{
  pkgs,
  config,
  lib,
  ...
}: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [stable.epson-escpr2 stable.cups-filters stable.epson-escpr];
    package = pkgs.stable.cups;
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

  hardware.sane.enable = true;

  environment.systemPackages =
    lib.mkIf config.services.printing.enable [pkgs.system-config-printer];
}
