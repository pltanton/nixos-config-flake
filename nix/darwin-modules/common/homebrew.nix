{pkgs, ...}: {
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      "gopls"
      "gnupg"
    ];

    casks = [
      "anytype"
      "cloudflare-warp"
      "docker"
      "nextcloud"
      "obsidian"
      "ghostty"
      "telegram"
      "zed"
      "slack"
      "unnaturalscrollwheels"
    ];
  };
}
