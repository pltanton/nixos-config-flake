{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "systemd"
        "wd"
        "cp"
        "history-substring-search"
        "nix-shell"
      ];
    };
    sessionVariables = {
      EDITOR = "nvim";
      JAVA_HOME = "${pkgs.adoptopenjdk-bin}";
      NIX_BUILD_SHELL = "zsh";
      LC_ALL = "en_US.UTF-8";
      PATH = "$HOME/.nix-profile/bin:$PATH";
    };
  };
}
