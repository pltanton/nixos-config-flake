{ pkgs, config, ... }: {
  programs.mako = with config.lib.base16.theme; {
    # package = pkgs.waylandPkgs.mako;
    enable = config.wayland.windowManager.sway.enable;
    font = "${fontUIName} ${fontUISize}";
    backgroundColor = "#${base01-hex}D9";
    borderColor = "#${base01-hex}";
    textColor = "#${base05-hex}";
    groupBy = "app-name";
    width = 500;
    height = 800;
    output = "DP-1";
  };
}
