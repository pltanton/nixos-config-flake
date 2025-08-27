{pkgs, ...}: {
  programs.autobrowser = {
    enable = true;
    variables = {
      home = "open -a 'Zen' 'ext+container:name=Personal&url={escape}'";
      work = "open -a 'Zen' 'ext+container:name=Work&url={escape}'";
      google-meet = "open -na 'Google Chrome' --args '--app={}'";
    };
    rules = [
      "work:app.bundle_id='com.tinyspeck.slackmacgap'"
      "work:app.bundle_id='com.cloudflare.1dot1dot1dot1.macos'"
      "work:url.regex='.*walletteam.*'"
      "work:url.regex='.*neocrypto.*'"
      "work:url.regex='.*jira.*'"
    ];
    default = "home";
  };
  home.packages = [pkgs.autobrowser];
}
