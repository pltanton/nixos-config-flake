{pkgs, lib, config, ...}: {
  environment.systemPackages = lib.mkIf config.services.cloudflare-warp.enable [pkgs.desktop-file-utils];
  services.cloudflare-warp = {
    enable = false;
  };
}
