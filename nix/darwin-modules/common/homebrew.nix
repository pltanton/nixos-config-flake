{pkgs, ...}: {
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  environment.systemPackages = [pkgs.neofetch];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    taps = [
      {
        name = "kde-mac/kde";
        clone_target = "https://invent.kde.org/packaging/homebrew-kde.git";
        force_auto_update = true;
      }
    ];

    brews = [
      "ykman"
      "node"
      "lunchy-go"
      "openssh"
    ];

    casks = [
      "gimp"
      "linearmouse"
      "adobe-acrobat-reader"
      "telegram-desktop"
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
      "mactex-no-gui"
      "thunderbird"
      "darktable"
      "rawtherapee"
      "sony-ps-remote-play"
      "libreoffice"
      "zoom"
      "obs"
      "commander-one"
    ];
  };
}
