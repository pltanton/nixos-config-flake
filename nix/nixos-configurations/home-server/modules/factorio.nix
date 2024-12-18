{config, ...}: {
  sops.secrets."factorio".mode = "0444";

  services.factorio = {
    enable = true;
    openFirewall = true;
    requireUserVerification = false;
    extraSettingsFile = config.sops.secrets."factorio".path;

    game-name = "Paphos gang";
    description = "Immigrants expansion beyond Cyprus";
    admins = ["pltanton"];
    public = false;
  };
}