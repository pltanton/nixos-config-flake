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

  security.wrappers = {
    mount.source = "${pkgs.utillinux}/bin/mount";
    umount.source = "${pkgs.utillinux}/bin/umount";
  };

  fileSystems."/mnt/home-nfs-archive" = {
    device = "10.100.0.1:/media/archive/archive";
    fsType = "nfs";
    options = ["x-systemd.automount,rw,defaults,noauto"];
  };

  fileSystems."/mnt/home-nfs-public" = {
    device = "10.100.0.1:/media/store/media";
    fsType = "nfs";
    options = ["x-systemd.automount,rw,defaults,noauto"];
  };


}
