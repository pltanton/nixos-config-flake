{ pkgs, config, lib, ... }:
let shouldEnable = config.wayland.windowManager.hyprland.enable;
in {
  config.systemd.user.services.swayidle.Install.WantedBy =
    lib.mkIf shouldEnable (lib.mkForce [ "hyprland-session.target" ]);
}
