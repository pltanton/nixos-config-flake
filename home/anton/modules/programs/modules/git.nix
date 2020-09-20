{ pkgs, secrets, ... }: {
  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    userEmail = "plotnikovanton@gmail.com";
    signing = {
      key = secrets.anton.gitSignFootprint;
      signByDefault = true;
    };
  };

  home.packages = with pkgs; [
    git-crypt
  ];
}
