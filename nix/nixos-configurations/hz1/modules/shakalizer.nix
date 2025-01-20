{
  config,
  pkgs,
  stdenv,
  ...
}:
with stdenv; {
  nixpkgs.config.packageOverrides = with pkgs;
    super: {
      shakalizer =
        pkgs.callPackage (super.fetchFromGitHub {
          owner = "trash-bot-factory";
          repo = "ShakalizerBot";
          rev = "d6993b2e2b3e821b33e70b1e69e53fe8679ef3b0";
          sha256 = "1qiq1nq8pd4m1gk1icbwn4r5qv88y34fg8jd6l9sn9wn9p3ws9ay";
        })
        _;
    };

  systemd.services.shakalizer = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "Start the Shakalizer bot.";
    serviceConfig = {
      Type = "simple";
      EnvironmentFile = "/secrets/shakalizer_env";
      ExecStart = "${pkgs.shakalizer}/bin/shakalizer.py";
    };
  };
}
