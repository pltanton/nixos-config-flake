{ pkgs, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "plotnikovanton@gmail.com";
      base_url = "https://bitwarden.kaliwe.ru";
    };
  };
}
