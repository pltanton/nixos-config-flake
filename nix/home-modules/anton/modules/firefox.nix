{pkgs, ...}: {
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
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Potential fix for cracking sound from pipewire
          "reader.parse-on-load.enabled" = false;
          "media.webspeech.synth.enabled" = false;
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
        ];

        userChrome = ''
          @-moz-document url(chrome://browser/content/browser.xul), url(chrome://browser/content/browser.xhtml) {
            #TabsToolbar {
              visibility: collapse !important;
              margin-bottom: 21px !important;
            }

            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
              display: none;
            }
          }
        '';
      };
    };
  };
}
