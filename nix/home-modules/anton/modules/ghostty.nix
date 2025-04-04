_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      gtk-single-instance = true;
      window-decoration = false;
      font-feature = ["calt" "liga"];
      font-size = 15;
      # shell-integration-features = "no-cursor";
      adjust-cursor-thickness = "500%";
      theme = "light:catppuccin-latte,dark:catppuccin-mocha";
    };
  };
}
