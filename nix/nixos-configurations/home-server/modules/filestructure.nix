_: {
  systemd.tmpfiles.rules = [
    "d /media 0755 root root"
    "d /media/store 0775 publicstore publicstore"
    "d /media/store/media 0775 publicstore publicstore"
  ];
}
