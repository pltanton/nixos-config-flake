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
      url = {
        "ssh://git@gitlab.ozon.ru/" = { insteadOf = "https://gitlab.ozon.ru/"; };
      };
      url = { "git@github.com:" = { insteadOf = [ "https://github.com/" ]; }; };
    };
  };

  home.packages = with pkgs; [ git-crypt ];
}
