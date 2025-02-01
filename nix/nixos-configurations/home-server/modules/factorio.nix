{
  config,
  pkgs,
  ...
}: {
  sops.secrets."factorio".mode = "0444";

  services.factorio = {
    enable = true;
    package = pkgs.factorio-headless;
    openFirewall = true;
    requireUserVerification = false;
    extraSettingsFile = config.sops.secrets."factorio".path;

    game-name = "Paphos gang";
    description = "Immigrants expansion beyond Cyprus";
    admins = ["pltanton"];
    public = false;
  };
}
