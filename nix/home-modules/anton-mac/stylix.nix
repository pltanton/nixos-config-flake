{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  stylix = {
    autoEnable = true;
    targets = {
      gtk.enable = false;
    };
  };
}
