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
          position = "0,0";
        }];
      };
      withDellDisplay = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 2.0;
            # position = "3840,960"; # for 1.0 scaling
            # position = "3202,601"; # for 1.2 scaling
            position = "3072,528"; # for 1.25 scaling
          }
          {
            criteria = "Dell Inc. DELL U2723QE JSJ91P3";
            status = "enable";
            scale = 1.25;
            position = "0,0";
          }
        ];
      };
    };
  };
}
