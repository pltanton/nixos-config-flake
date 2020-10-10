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
    };
  };
}
