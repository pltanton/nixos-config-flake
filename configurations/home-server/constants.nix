rec {
  archiveMountPoint = "/media/archive";
  storeMountPoint = "/media/store";

  publicMedia = "${storeMountPoint}/media";
  musicDir = "${publicMedia}/music";

  mediaAppHomes = "${publicMedia}/app-homes";

  TZ = "Europe/Moscow";
}
