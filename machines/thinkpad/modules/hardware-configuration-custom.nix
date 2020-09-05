{ pkgs, ... }: {
  hardware = {
    enableRedistributableFirmware = true;

    opengl.driSupport32Bit = true;
    opengl.enable = true;
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

    steam-hardware.enable = true;

    trackpoint = {
      enable = true;
      emulateWheel = true;
    };

    sane.enable = true;
    #sane.snapshot = true;
    sane.netConf = "192.168.20.3";
  };

}
