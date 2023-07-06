{ pkgs, lib, config, ... }:

{
  xresources = {
    # extraConfig = builtins.readFile
    #   (config.lib.base16.templateFile { name = "xresources"; });

    properties = {
      # "*dpi" = "192";
      "Xft.dpi" = "192";
    };
  };
}
