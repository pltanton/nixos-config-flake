{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 18000;
  };
}
