{ pkgs, ... }:
let printerIp = "192.168.30.18";
in {
  # imports = [ inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call ];

  services.printing.enable = true;
  hardware.printers.ensurePrinters = [{
    name = "DCP-T710W";
    model = "everywhere";
    deviceUri = "ipp://${printerIp}/";
  }];

  hardware.sane = {
    enable = true;
    brscan4 = {
      enable = true;
      netDevices = {
        home = {
          model = "DCP-T710W";
          ip = printerIp;
        };
      };
    };
  };

}
