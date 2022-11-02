{ pkgs, config, lib, ... }: {
  xdg.configFile."easyeffects/output/advanced-auto-gain.json" =
    lib.mkIf config.services.easyeffects.enable ({
      text = builtins.readFile ./advanced-auto-gain.json;
    });

  services.easyeffects = {
    enable = false;
    preset = "advanced-auto-gain";
  };

}
