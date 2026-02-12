{lib, ...}: {
  programs.hyprland.enable = lib.mkForce false;
  programs.hyprland.withUWSM = lib.mkForce false;
}
