{ pkgs, config, ... }:

{
  xresources = {
    extraConfig = builtins.readFile (config.lib.base16.templateFile { name = "xresources"; });
  };
}
