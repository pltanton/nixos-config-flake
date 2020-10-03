{ pkgs, config, lib, home-manager, ... }: {
  services.kanshi = {
    enable = true;
    profiles = {
      bigLg = {
        outputs = [
          {
            criteria = "Goldstar Company Ltd LG HDR 4K 0x0000D544";
            status = "enable";
          }
          {
            criteria = "eDP-1";
            status = "enable";
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
