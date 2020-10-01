{ pkgs, config, theme, ... }:
{
  programs.rofi = {
    enable = true;

    theme = "${config.lib.base16.templateFile { name = "rofi"; }}";

    font = with config.lib.base16.theme; "${fontUIName} ${fontUISize}";

    scrollbar = false;
    separator = "none";
  };
}
