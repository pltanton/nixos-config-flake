{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-wayland;
    # package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    #   extraPolicies = { ExtensionSettings = { }; };
    # };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      sidebery
      bitwarden
      vim-vixen
      privacy-badger
      ublock-origin
      react-devtools
      stylus
      foxyproxy-standard
    ];
    profiles = {
      default = {
        id = 0;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "gfx.webrender.all" = true;
        };
        userChrome = ''
          #TabsToolbar {
            visibility: collapse !important;
            margin-bottom: 21px !important;
          }

          #titlebar {
            visibility: collapse !important;
          }

          #sidebar-header {
            visibility: collapse !important;
          }
        '';
      };
    };
  };
}
