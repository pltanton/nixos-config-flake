{lib, ...}: let
  target = "wayland-session@Hyprland.target";
  # target = "graphical-session.target";
in {
  config.systemd.user.services = {
    kanshi.Unit.After = lib.mkForce [target];
    waybar.Unit.After = lib.mkForce [target];
    hyprpaper.Unit.After = lib.mkForce [target];
    hypridle.Unit.After = lib.mkForce [target];
    network-manager-applet.Unit.After = lib.mkForce [target];
    blueman-applet.Unit.After = lib.mkForce [target];
    cliphist.Unit.After = lib.mkForce [target];
    cliphist-images.Unit.After = lib.mkForce [target];
    swaync.Unit.After = lib.mkForce [target];
    nextcloud-client.Unit.After = lib.mkForce [target];
  };
}
