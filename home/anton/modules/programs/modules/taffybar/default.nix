{ pkgs, config, ... }: {
  home.file.".config/taffybar/taffybar.css".text = import ./taffybar.css config.lib.base16.theme;
  services.taffybar.enable = false;
}
