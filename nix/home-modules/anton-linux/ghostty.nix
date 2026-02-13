_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      gtk-single-instance = true;
      window-decoration = "auto";
      font-feature = ["calt" "liga"];
      font-size = 11;
      adjust-cursor-thickness = "500%";
      theme = "dankcolors";
      app-notifications = "no-clipboard-copy,no-config-reload";
    };
  };
}
