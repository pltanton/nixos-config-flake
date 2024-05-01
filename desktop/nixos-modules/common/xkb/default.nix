{ pkgs, config, ... }: {
  services.xserver.xkb.extraLayouts = {
    el_dv = {
      symbolsFile = ./el_dv;
      description = "Greek Dvorak layout";
      languages = [ "gr" ];
    };
  };
}
