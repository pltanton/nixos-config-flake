{lib, ...}: let
  target = "graphical-session.target";
in {
  systemd.user.services = {
    kanshi.Unit.After = lib.mkForce [target];
    cliphist.Unit.After = lib.mkForce [target];
    cliphist-images.Unit.After = lib.mkForce [target];
    swaync.Unit.After = lib.mkForce [target];
    nextcloud-client.Unit.After = lib.mkForce [target];
  };
}
