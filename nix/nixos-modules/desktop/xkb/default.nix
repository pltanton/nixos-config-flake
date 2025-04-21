_: {
  services.xserver.xkb.extraLayouts = {
    gr-dvorak = {
      symbolsFile = ./gr-dvorak;
      description = "Greek (Dvorak)";
      languages = ["ell"];
    };
    layout = "us,us";
    variant = "dvorak,";
    options = "eurosign:e,grp:win_space_toggle";
  };
}
