{
  pkgs,
  lib,
  ...
}: {
  xfconf.enable = lib.mkForce false;
}
