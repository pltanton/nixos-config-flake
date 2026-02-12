{pkgs, ...}: {
  programs.waybar = {
    style = builtins.readFile ./waybar.css;
    package = pkgs.unstable.waybar;
    enable = true;
    systemd.enable = true;
  };
}
