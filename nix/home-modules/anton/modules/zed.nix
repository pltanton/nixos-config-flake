_: {
  programs.zed-editor = {
    enable = false;
    extensions = ["nix"];
    userSettings = {
      vim_mode = true;
    };
  };
}
