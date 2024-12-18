_: {
  fileSystems = {
    "/tmp/ramdisk" = {
      fsType = "tmpfs";
      device = "tmpfs";
      options = ["noexec,defaults,noatime,size=2048M,x-gvfs-show,mode=1777"];
    };
  };

  systemd.tmpfiles.rules = [
    "d /tmp/ramdisk/intellij/JetBrains 0777 root root"
  ];
}
