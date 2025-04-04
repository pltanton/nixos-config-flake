{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = with config.stylix.fonts; {
        normal = {
          family = monospace.name;
          style = "Regular";
        };
        size = 14;
      };
    };
  };
}
