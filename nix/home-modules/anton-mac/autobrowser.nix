{pkgs, ...}: {
  programs.autobrowser = {
    enable = true;
    variables = {
      home = "open -a 'Zen' 'ext+container:name=Personal&url={}'";
      work = "open -a 'Zen' 'ext+container:name=Work&url={}'";
      google-meet = "open -na 'Google Chrome' --args '--app={}'";
    };
    rules = [
      "work:app.bundle_id='com.tinyspeck.slackmacgap'"
      "work:app.bundle_id='com.tinyspeck.slackmacgap'"
      "work:app.bundle_id='com.cloudflare.1dot1dot1dot1.macos'"
      "google-meet:url.host='meet.google.com'"
    ];
    default = "home";
  };
  home.packages = [pkgs.autobrowser];
}
