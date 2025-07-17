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
      "node"
      "lunchy-go"
      "openssh"
    ];

    casks = [
      "linearmouse"
      # "telegram-desktop"
      "telegram"
      "intellij-idea"
      "raycast"
      "cloudflare-warp"
      "nextcloud"
      "obsidian"
      "ghostty"
      "docker-desktop"
      "zen"
      "slack"
      "sf-symbols"
      "font-sf-pro"
      "google-chrome"
      "inkscape"
      "zed"
      "jordanbaird-ice"
      "vlc"
      "pritunl"
      "yubico-authenticator"
    ];
  };
}
