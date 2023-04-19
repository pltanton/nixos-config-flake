{ pkgs, lib, config, secrets, ... }: {
  services.factorio = {
    package = pkgs.unstable.factorio-headless;
    enable = false;
    token = secrets.factorio.token;
    description = "Elite community server for the best ones of human race.";
    public = false;
    game-name = "Human race elite";
    game-password = secrets.factorio.game-password;
    requireUserVerification = false;
    loadLatestSave = true;
    admins = [ "pltanton" ];
  };

  networking.firewall.allowedUDPPorts =
    lib.mkIf (config.services.factorio.enable) [ 34197 ];
}
