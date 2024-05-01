{ pkgs, config, lib, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr epson-escpr2 ];
  };

  hardware.sane.enable = true;

  environment.systemPackages =
    lib.mkIf config.services.printing.enable [ pkgs.system-config-printer ];
}
