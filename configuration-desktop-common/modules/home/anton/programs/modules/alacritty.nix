{ lib, pkgs, config, ... }: {
  programs.alacritty = {
    enable = true;
    settings.font.size = lib.mkForce 14;
    # settings.live_config_reload = true;
  };
}
