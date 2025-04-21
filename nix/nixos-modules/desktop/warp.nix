{pkgs, ...}: {
  environment.systemPackages = [pkgs.desktop-file-utils];
  services.cloudflare-warp = {
    enable = true;
  };
}
