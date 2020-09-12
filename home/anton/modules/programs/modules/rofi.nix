{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;

    theme = "${config.lib.base16.templateFile { name = "rofi"; }}";

    scrollbar = false;
    separator = "none";
  };
}
