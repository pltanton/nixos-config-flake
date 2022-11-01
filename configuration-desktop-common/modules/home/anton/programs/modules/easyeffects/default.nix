{ pkgs, ... }: {
  xdg.configFile."easyeffects/output/advanced-auto-gain.json".text =
    builtins.readFile ./advanced-auto-gain.json;

  services.easyeffects = {
    enable = true;
    preset = "advanced-auto-gain";
  };

}
