{ pkgs, config, lib, ... }: {
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
            status = "disable";
          }
        ];
        exec = "echo Xft.dpi: 192 | ${pkgs.xorg.xrdb}/bin/xrdb -merge";
      };
      laptopOnly = {
        outputs = [{
          criteria = "eDP-1";
          status = "enable";
        }];
        exec = "echo Xft.dpi: 96 | ${pkgs.xorg.xrdb}/bin/xrdb -merge";
      };
    };
  };
}
