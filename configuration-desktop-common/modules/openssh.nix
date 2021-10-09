{ pkgs, ... }: {
  services.openssh = {
    permitRootLogin = "yes";
    enable = true;
    forwardX11 = true;
  };
}
