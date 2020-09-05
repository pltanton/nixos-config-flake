{pkgs,...}:
{
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

    saned.enable = true;
  };
}
