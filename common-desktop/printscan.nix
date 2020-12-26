{ pkgs, ... }: {
  services = {
    printing = {
      enable = true;
      drivers = [
        pkgs.gutenprint
        pkgs.brlaser
        pkgs.brgenml1lpr
        pkgs.brgenml1cupswrapper
        pkgs.brother-dcp-t710
      ];
    };

    saned.enable = true;
  };
}
