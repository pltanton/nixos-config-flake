{pkgs, ...}: {
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  environment.systemPackages = [pkgs.neofetch];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      "ollama"
      "ykman"
    ];

    casks = [
      "raycast"
      "anytype"
      "cloudflare-warp"
      "docker"
      "nextcloud"
      "obsidian"
      "ghostty"
      "telegram"
      "zed"
      "zen"
      "slack"
      "unnaturalscrollwheels"
      "karabiner-elements"
      "ubersicht"
    ];
  };
}
