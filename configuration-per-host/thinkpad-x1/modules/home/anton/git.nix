{ pkgs, secrets, ... }: {
  programs.git = {
    userEmail = "plotnikovanton@gmail.com";

    signing = {
     key = secrets.anton.gitSignFootprint;
     signByDefault = true;
    };
  };
}
