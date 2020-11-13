{ pkgs, config, ... }:
with config.lib.base16.theme; {
  programs.rofi = {
    enable = true;
    font = "${fontUIName} 20";
    theme = "${config.lib.base16.templateFile { name = "rofi"; type = "color"; }}";
  };
}
