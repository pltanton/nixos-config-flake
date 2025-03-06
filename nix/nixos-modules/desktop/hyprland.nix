{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    enable = true;
    withUWSM = true;
  };
}
