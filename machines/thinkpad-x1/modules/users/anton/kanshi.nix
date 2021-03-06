{ pkgs, config, lib, home-manager, ... }: {
  services.kanshi = {
    enable = true;
    package = pkgs.waylandPkgs.kanshi;
    profiles = {
      bigLg = {
        outputs = [
          {
            criteria = "Goldstar Company Ltd LG HDR 4K 0x0000D544";
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "3840,720";
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
            mode = "3840x2160@30Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
      tvOnlyThreeOutputs = {
        outputs = [
          {
            criteria = "Unknown Mi TV 0x00000001";
            status = "enable";
            mode = "3840x2160@30Hz";
          }
          {
            criteria = "DP-2";
            status = "disable";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    };
  };
}
