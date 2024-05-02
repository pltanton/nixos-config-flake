{
  pkgs,
  config,
  ...
}: let
  configDir = "${config.xdg.configHome}/ranger";
  configFile = "${configDir}/rc.conf";
in {
  home.packages = with pkgs; [ranger ueberzug];

  home.file."${configFile}".text = with config.lib.base16.theme; ''
    set preview_images true
    set preview_images_method kitty
  '';
}
