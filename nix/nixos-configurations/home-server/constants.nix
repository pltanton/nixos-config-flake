rec {
  archiveMountPoint = "/media/archive";
  archive = archiveMountPoint;
  storeMountPoint = "/media/store";

  publicMedia = "${storeMountPoint}/media";
  musicDir = "${publicMedia}/music";

  mediaAppHomes = "${publicMedia}/app-homes";

  TZ = "Europe/Moscow";
}
