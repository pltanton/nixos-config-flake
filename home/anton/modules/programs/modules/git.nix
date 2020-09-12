{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    userEmail = "plotnikovanton@gmail.com";
  };

  home.packages = with pkgs; [
    git-crypt
  ];
}
