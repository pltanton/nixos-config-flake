{ pkgs, config, ... }: {
  services.xserver.xkb.extraLayouts = {
    el_dv = {
      symbolsFile = ./el_dv;
      languages = [ "gr" ];
    };
  };
}
