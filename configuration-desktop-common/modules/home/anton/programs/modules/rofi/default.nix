{ pkgs, config, ... }:
with config.lib.base16.theme; {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override {
      plugins = with pkgs; [ rofi-vpn rofi-rbw rofi-emoji ];
    };
    font = "${fontUIName} 20";
    theme = ./nord.rasi;
    # theme = "${config.lib.base16.templateFile {
    #   name = "rofi";
    #   # type = "color";
    # }}";
  };
}
