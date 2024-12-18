{
  pkgs,
  config,
  ...
}: {
  services.xserver.xkb.extraLayouts = {
    gr-dvorak = {
      symbolsFile = ./gr-dvorak;
      description = "Greek (Dvorak)";
      languages = ["ell"];
    };
  };
}
