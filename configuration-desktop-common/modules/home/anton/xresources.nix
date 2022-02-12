{ pkgs, lib, config, ... }:

{
  xresources = {
    extraConfig = builtins.readFile
      (config.lib.base16.templateFile { name = "xresources"; });

    properties = lib.mkIf config.wayland.windowManager.sway.enable {
      "*dpi" = "192";
      "Xft.dpi" = "192";
    };
  };
}
