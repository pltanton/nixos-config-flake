{ pkgs, config, lib, home-manager, ... }: {
  services.kanshi = {
    enable = true;
    # package = pkgs.waylandPkgs.kanshi;
    profiles = {
      ozonThinkVision = {
        outputs = [
          {
            criteria = "Lenovo Group Limited LEN T27p-10";
            status = "enable";
            position = "0,0";
            mode = "3840x2160@60Hz";
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "3840,888";
            scale = 1.7;
          }
        ];
      };
      bigLg = {
        outputs = [
          {
            # criteria = "Goldstar Company Ltd LG HDR 4K 0x0000D544";
            criteria = "Goldstar Company Ltd LG HDR 4K 0x00000101";
            status = "enable";
            position = "0,0";
            mode = "3840x2160@59.997";
            # scale = 1.2;
            scale = 1.0;
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "3840,888";
            # position = "3202,530";
            scale = 1.7;
            # position = "3840,1080";
            # scale = 2.0;
          }
        ];
      };
      laptopOnly = {
        outputs = [{
          criteria = "eDP-1";
          status = "enable";
        }];
      };
      tvOnlyTwoOutputs = {
        outputs = [
          {
            criteria = "Unknown Mi TV 0x00000001";
            status = "enable";
            mode = "1920x1080@59.940Hz";
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,1080";
            scale = 1.7;
          }
        ];
      };
      tvOnlyThreeOutputs = {
        outputs = [
          {
            criteria = "Unknown Mi TV 0x00000001";
            status = "enable";
            mode = "1920x1080@59.940Hz";
            position = "0,0";
          }
          {
            criteria = "DP-2";
            status = "enable";
            position = "0,1080";
            mode = "3840x2160@59.997";
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "3840,1968";
            scale = 1.7;
          }
        ];
      };
    };
  };
}
