{
  pkgs,
  config,
  lib,
  home-manager,
  ...
}: {
  services.kanshi = {
    enable = true;
    # package = pkgs.waylandPkgs.kanshi;
    profiles = {
      laptopOnly = {
        outputs = [
          {
            criteria = "BOE 0x07C8 (eDP-1)";
            status = "enable";
            scale = 2.0;
          }
        ];
      };
    };
  };
}
