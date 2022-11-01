{ pkgs, inputs, ... }: {

  programs.firefox = {
    enable = true;
    # package = inputs.firefox-nightly.firefox-nightly-bin;
    # package = pkgs.firefox;
    # package = pkgs.latest.firefox-nightly-bin;
    # package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    package = pkgs.firefox-wayland;
    #   extraPolicies = { ExtensionSettings = { }; };
    # };
    # enableGnomeExtensions = true;
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
    profiles = {
      default = {
        id = 0;
        settings = {
          # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = "-1.0";
          "privacy.webrtc.legacyGlobalIndicator" = false;
        };
        # userChrome = ''
        #   #TabsToolbar {
        #     visibility: collapse !important;
        #     margin-bottom: 21px !important;
        #   }

        #   #titlebar {
        #     visibility: collapse !important;
        #   }

        #   #sidebar-header {
        #     visibility: collapse !important;
        #   }
        # '';
      };
      nc = {
        id = 1;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = "-1.0";
        };
      };
    };
  };
}
