{
  pkgs,
  config,
  lib,
  ...
}: {
  xdg.configFile = lib.mkIf config.services.easyeffects.enable {
    "easyeffects/output/advanced-auto-gain.json" = {
      text = builtins.readFile ./advanced-auto-gain.json;
    };

    "easyeffects/output/loudness-equalizer.json" = {
      text = builtins.readFile ./loudness-equalizer.json;
    };

    "easyeffects/input/input-preset.json" = {
      text = builtins.readFile ./input-preset.json;
    };

    "easyeffects/output/none.json" = {text = builtins.readFile ./none.json;};
  };

  services.easyeffects = {
    enable = true;
    # package = pkgs.easyeffects.override {
    #   speexdsp = pkgs.speexdsp.overrideAttrs (old: {configureFlags = [];});
    # };
    # preset = "advanced-auto-gain";
  };
}
