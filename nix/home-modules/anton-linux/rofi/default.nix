{
  pkgs,
  config,
  lib,
  ...
}: let
  rofi = pkgs.rofi.override {
    plugins = with pkgs; [rofi-emoji rofi-power-menu];
  };
in {
  programs.rofi = {
    enable = true;
    package = rofi;
    font = "Inter 14";
    extraConfig = {
      width = 30;
      line-margin = 10;
      lines = 6;
      columns = 2;

      display-emoji = "🫠";
      display-ssh = "";
      display-run = "";
      display-drun = "";
      display-window = "";
      display-combi = "";
      display-prompt = "";
      show-icons = false;
    };
  };

  home.packages = with pkgs; [
    rofi-rbw
    wtype
  ];
}
