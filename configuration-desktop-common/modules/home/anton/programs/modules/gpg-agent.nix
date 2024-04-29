{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 18000;
    # pinentryPackage = pkgs.pinentry-gnome3;
  };
}
