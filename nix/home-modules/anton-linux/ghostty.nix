_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      gtk-single-instance = true;
      window-decoration = "auto";
      font-feature = ["calt" "liga"];
      font-size = 11;
      # shell-integration-features = "no-cursor";
      adjust-cursor-thickness = "500%";
      theme = "light:catppuccin-latte,dark:catppuccin-mocha";
    };
  };
}
