{ pkgs, ... }: {
  users.users.radarr = { extraGroups = [ "publicstore" ]; };
  services.radarr = {
    enable = true;
    dataDir = "/media/store/media/app-homes/radarr-home/";
    # user = "publicstore";
    # group = "publicstore";
    openFirewall = true;
  };

  users.users.sonarr = { extraGroups = [ "publicstore" ]; };
  services.sonarr = {
    enable = true;
    dataDir = "/media/store/media/app-homes/sonarr-home/";
    # user = "publicstore";
    # group = "publicstore";
    openFirewall = true;
  };

  users.users.jackett = { extraGroups = [ "publicstore" ]; };
  services.jackett = {
    enable = true;
    dataDir = "/media/store/media/app-homes/jackett-home/";
    # user = "publicstore";
    # group = "publicstore";
    openFirewall = true;
  };
}
