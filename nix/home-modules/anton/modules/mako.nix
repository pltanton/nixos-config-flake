{
  pkgs,
  config,
  lib,
  ...
}: {
  services.mako = with config.lib.stylix.colors; {
    enable = true;
    borderColor = lib.mkForce "#${base01-hex}";
    width = 500;
    height = 800;
    anchor = "top-center";
    extraConfig = ''
      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
