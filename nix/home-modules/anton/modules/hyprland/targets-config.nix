{lib, ...}: let
in {
  config.systemd.user.services = {
    kanshi.Unit.After = lib.mkForce ["graphical-session.target"];
    waybar.Unit.After = lib.mkForce ["graphical-session.target"];
    hyprpaper.Unit.After = lib.mkForce ["graphical-session.target"];
    hypridle.Unit.After = lib.mkForce ["graphical-session.target"];
    network-manager-applet.Unit.After = lib.mkForce ["graphical-session.target"];
    blueman-applet.Unit.After = lib.mkForce ["graphical-session.target"];
    cliphist.Unit.After = lib.mkForce ["graphical-session.target"];
    cliphist-images.Unit.After = lib.mkForce ["graphical-session.target"];
    swaync.Unit.After = lib.mkForce ["graphical-session.target"];
    nextcloud-client.Unit.After = lib.mkForce ["graphical-session.target"];
  };
}
