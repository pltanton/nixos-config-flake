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
      "ykman"
    ];

    casks = [
      "linearmouse"
      "telegram-desktop"
      "intellij-idea"
      "raycast"
      "cloudflare-warp"
      "nextcloud"
      "obsidian"
      "ghostty"
      "docker-desktop"
      "zen"
      "slack"
    ];
  };
}
