{ pkgs, osConfig, lib, ... }: {
  services.mako = with osConfig.lib.stylix.colors; {
    enable = true;
    package = pkgs.waylandPkgs.mako;
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
