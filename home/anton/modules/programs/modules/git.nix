{ pkgs, secrets, ... }: {
  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    userEmail = "plotnikovanton@gmail.com";
    signing = {
      key = secrets.anton.gitSignFootprint;
      signByDefault = true;
    };
    extraConfig = {
      # url = {
      #   "ssh://git@gitlab.com/" = { insteadOf = "https://gitlab.com/"; };
      # };
      url = {
        "https://9a11b568cf26fe4a40b0d5c5a95860efeb46e798:x-oauth-basic@github.com/intellectokids-backend/" =
          {
            insteadOf = "https://github.com/intellectokids-backend";
          };
      };
    };
  };

  home.packages = with pkgs; [ git-crypt ];
}
