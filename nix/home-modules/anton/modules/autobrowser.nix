{pkgs, ...}: {
  programs.autobrowser = {
    # package = inputs.autobrowser.packages.x86_64-linux.default;
    enable = true;
    variables = {
      work = "firefox 'ext+container:name=Work&url=_'";
      home = "firefox _";
      meet-work = "chromium '--app=_?authuser=1'";
      meet-personal = "chromium '--app=_?authuser=0'";
    };
    rules = [
      "meet-work:url.host='meet.google.com';app.class=Slack"
      "meet-personal:url.host='meet.google.com'"
      "work:app.class=Slack"
    ];
    default = "home";
  };
  home.packages = [pkgs.autobrowser];
}
