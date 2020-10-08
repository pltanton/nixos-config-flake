{ pkgs, ... }: {
  services.redshift = {
    enable = false;
    latitude = "59.9375";
    longitude = "30.308611";
  };
}
