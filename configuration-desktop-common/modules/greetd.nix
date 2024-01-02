{ pkgs, config, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "cage -s -- regreet";
      };
    };
  };

  programs.regreet = {
    enable = true;
  };
}