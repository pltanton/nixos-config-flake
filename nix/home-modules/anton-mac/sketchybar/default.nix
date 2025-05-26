{pkgs, ...}: {
  services.sketchybar = {
    enable = true;
    config = {
      source = ./sketchybar;
    };
  };
}
