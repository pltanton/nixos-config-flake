{inputs, ...}: let
  themeDir = inputs.catppuccin-zen + "/themes/Mocha/Blue";
in {
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      isDefault = true;
      path = "default";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "gfx.webrender.enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
      };
      userChrome = builtins.readFile (themeDir + "/userChrome.css");
      userContent = builtins.readFile (themeDir + "/userContent.css");
    };
  };

  home.file.".zen/default/chrome/zen-logo-mocha.svg".source =
    themeDir + "/zen-logo-mocha.svg";
}
