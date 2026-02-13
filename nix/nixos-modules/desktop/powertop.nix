{pkgs, ...}: {
  powerManagement.powertop = {
    enable = true;
    postStart = ''
      ${pkgs.powertop}/bin/powertop --auto-tune
    '';
  };
}
