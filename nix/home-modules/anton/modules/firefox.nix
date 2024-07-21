{
  pkgs,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      # See nixpkgs' firefox/wrapper.nix to check which options you can use
      nativeMessagingHosts = [
        pkgs.fx-cast-bridge
      ];
    };

    profiles = {
      default = {
        id = 0;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = "-1.0";
          "privacy.webrtc.legacyGlobalIndicator" = false;
        };

        extensions = with config.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          react-devtools
          stylus
          foxyproxy-standard
          multi-account-containers
          sponsorblock
          vimium
        ];
      };
    };
  };
}
