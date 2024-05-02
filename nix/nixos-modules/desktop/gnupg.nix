{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    # pinentryFlavor = "curses";
  };
  services.pcscd.enable = true;
}
