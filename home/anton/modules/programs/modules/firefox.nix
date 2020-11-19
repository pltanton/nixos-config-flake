{ pkgs, ... }: {

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    enableAdobeFlash = false;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      sidebery
      bitwarden
      vim-vixen
      privacy-badger
      ublock-origin
      react-devtools
      stylus
      dark-night-mode
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
