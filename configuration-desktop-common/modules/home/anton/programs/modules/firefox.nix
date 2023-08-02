{ pkgs, inputs, ... }: {

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    profiles = {
      default = {
        id = 0;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = "-1.0";
          "privacy.webrtc.legacyGlobalIndicator" = false;
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          react-devtools
          stylus
          foxyproxy-standard
          multi-account-containers
          sponsorblock
          vimium

          pkgs.nur.repos.ethancedwards8.firefox-addons.enhancer-for-youtube
        ];
      };
      nc = {
        id = 1;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = "-1.0";
          "privacy.webrtc.legacyGlobalIndicator" = false;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          react-devtools
          stylus
          foxyproxy-standard
          multi-account-containers
          sponsorblock
          vimium

          pkgs.nur.repos.ethancedwards8.firefox-addons.enhancer-for-youtube
        ];
      };
    };
  };
}
