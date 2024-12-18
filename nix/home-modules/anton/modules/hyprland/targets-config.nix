{
  lib,
  ...
}: {
  config.systemd.user.services.kanshi.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.waybar.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.hyprpaper.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.hypridle.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.network-manager-applet.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.blueman-applet.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.cliphist.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.cliphist-images.Unit.After = lib.mkForce [ "graphical-session.target" ];
  config.systemd.user.services.swaync.Unit.After = lib.mkForce [ "graphical-session.target" ];

  config.systemd.user.services.nextcloud-client.Unit.After = lib.mkForce [ "graphical-session.target" ];
}
