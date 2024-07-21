{pkgs, ...}: {
  programs.autobrowser = {
    # package = inputs.autobrowser.packages.x86_64-linux.default;
    enable = true;
    variables = {
      work = "firefox 'ext+container:name=Work&url={}'";
      home = "firefox {}";
    };
    rules = [
      "work:app.class=Slack"
      "work:app.class=Alacritty"
      ":app.class=Alacritty"
    ];
    default = "home";
  };
  home.packages = [pkgs.autobrowser];
}
