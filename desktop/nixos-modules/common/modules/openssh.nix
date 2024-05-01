{ pkgs, ... }: {
  services.openssh = {
    settings.PermitRootLogin = "yes";
    enable = true;
  };
}
