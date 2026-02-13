{inputs, ...}: {
  imports = with inputs; [
    dms.homeModules.dank-material-shell
    dms.homeModules.niri
  ];
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    enableDynamicTheming = true;
    niri = {
      enableSpawn = false;
      enableKeybinds = false;
    };
  };
}
