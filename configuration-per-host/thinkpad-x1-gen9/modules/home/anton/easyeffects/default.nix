{ pkgs, config, lib, ... }: {
  xdg.configFile = lib.mkIf config.services.easyeffects.enable ({
    "easyeffects/output/advanced-auto-gain.json" = {
      text = builtins.readFile ./advanced-auto-gain.json;
    };

    "easyeffects/output/loudness-equalizer.json" = {
      text = builtins.readFile ./loudness-equalizer.json;
    };

    "easyeffects/output/none.json" = { text = builtins.readFile ./none.json; };
  });

  services.easyeffects = {
    enable = true;
    # preset = "advanced-auto-gain";
  };

}
