{ pkgs, ... }: {
  services.openssh = {
    permitRootLogin = "no";
    enable = true;
    forwardX11 = true;
  };
}
