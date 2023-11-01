{ pkgs, secrets, ... }: {
  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    # Should be set in pre-host configuration
    # userEmail = "plotnikovanton@gmail.com";
    # signing = {
    #  key = secrets.anton.gitSignFootprint;
    #  signByDefault = true;
    # };
    extraConfig = {
      url = { "git@github.com:" = { insteadOf = [ "https://github.com/" ]; }; };

      url = {
        "ssh://git@gitlab.fix.ru/" = { insteadOf = "https://gitlab.fix.ru/"; };
      };

      url = {
        "ssh://git@gitlab.walletteam.org/" = {
          insteadOf = "https://gitlab.walletteam.org/";
        };
      };
    };
  };

  home.packages = with pkgs; [ git-crypt ];
}
