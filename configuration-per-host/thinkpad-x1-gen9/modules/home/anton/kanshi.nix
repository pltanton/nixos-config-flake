{ pkgs, config, lib, home-manager, ... }: {
  services.kanshi = {
    enable = true;
    # package = pkgs.waylandPkgs.kanshi;
    profiles = {
      laptopOnly = {
        outputs = [{
          criteria = "California Institute of Technology 0x1403";
          status = "enable";
          scale = 2.0;
        }];
      };
      withDellDisplay = {
        outputs = [
          {
            criteria = "Dell Inc. DELL U2723QE 93TGGH3 (DP-3)";
            status = "enable";
            scale = 1.0;
          }
          {
            criteria = "California Institute of Technology 0x1403 (eDP-1)";
            status = "disable";
            scale = 2.0;
          }
        ];
      };
    };
  };
}
