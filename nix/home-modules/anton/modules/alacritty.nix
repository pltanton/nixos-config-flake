{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings.font.size = lib.mkForce 14;
  };
}
