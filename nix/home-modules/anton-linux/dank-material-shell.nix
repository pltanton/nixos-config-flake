{inputs, ...}: {
  imports = with inputs; [
    dms.homeModules.dank-material-shell
    dms.homeModules.niri
  ];
  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableSpawn = true;
      enableKeybinds = true;
      includes.enable = true;
    };
  };
}
