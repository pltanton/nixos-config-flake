{ pkgs, secrets, ... }: {
  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    userEmail = "antplotnikov@ozon.ru";
    signing = {
     key = secrets.anton.gitSignFootprint;
     signByDefault = true;
    };
    extraConfig = {
      # url = {
      #   "ssh://git@gitlab.com/" = { insteadOf = "https://gitlab.com/"; };
      # };
      url = { "git@github.com:" = { insteadOf = [ "https://github.com/" ]; }; };
    };
  };

  home.packages = with pkgs; [ git-crypt ];
}
