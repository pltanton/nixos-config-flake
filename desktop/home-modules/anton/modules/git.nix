{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    userEmail = "plotnikovanton@gmail.com";

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


    signing = {
      key = null;
      signByDefault = true;
    };
  };


  home.packages = with pkgs; [ git-crypt ];
}
