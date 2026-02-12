{
  pkgs,
  config,
  ...
}: {
  hyprland-submap = pkgs.writeShellApplication {
    name = "hyprland-submap";
    runtimeInputs = with pkgs; [netcat];
    text = builtins.readFile ./hyprland-submap.bash;
  };

  hyprland-kbd = pkgs.writeShellApplication {
    name = "hyprland-kbd";
    runtimeInputs = with pkgs; [
      gnugrep
      netcat
      busybox
      config.wayland.windowManager.hyprland.package
    ];
    text = builtins.readFile ./hyprland-kbd.bash;
  };
}
