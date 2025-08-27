{pkgs, ...}: {
  programs.autobrowser = {
    # package = inputs.autobrowser.packages.x86_64-linux.default;
    enable = true;
    variables = {
      work = "zen-beta ext+container:name=Work&url={}";
      home = "zen-beta {}";
      meet-work = "chromium '--app={}?authuser=1'";
      meet-personal = "chromium '--app={}?authuser=0'";
    };
    rules = [
      "meet-work:url.host='meet.google.com';app.class=Slack"
      "home:url.host='meet.google.com'"
      "work:url.regex='.*walletteam.*'"
      "work:app.class=Slack"
    ];
    default = "home";
  };
  home.packages = [pkgs.autobrowser];
}
