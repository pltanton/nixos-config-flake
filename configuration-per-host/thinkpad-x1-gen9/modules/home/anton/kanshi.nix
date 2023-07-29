{ pkgs, config, lib, home-manager, ... }: {
  services.kanshi = {
    enable = true;
    # package = pkgs.waylandPkgs.kanshi;
    profiles = {
      laptopOnly = {
        outputs = [{
          criteria = "eDP-1";
          status = "enable";
          scale = 2.0;
        }];
      };
      withDellDisplay = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            scale = 2.0;
          }
          {
            criteria = "Dell Inc. DELL U2723QE JSJ91P3";
            status = "enable";
            scale = 1.0;
          }
        ];
      };
    };
  };
}
