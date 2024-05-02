{pkgs, ...}: {
  security.sudo = {
    extraConfig = ''
      Defaults insults
    '';
  };
}
