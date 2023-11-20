{ pkgs, inputs, ... }: {

  programs.firefox = {
    enable = true;

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

          # pkgs.nur.repos.ethancedwards8.firefox-addons.enhancer-for-youtube
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

          # pkgs.nur.repos.ethancedwards8.firefox-addons.e	MINISTRY OF EDUCATION, SPORT AND YOUTH - ADULTS EDUCATIONAL CENTRES	MINISTRY OF EDUCATION, SPORT AND YOUTH - ADULTS EDUCATIONAL CENTRESnhancer-for-youtube
        ];
      };
    };
  };
}
