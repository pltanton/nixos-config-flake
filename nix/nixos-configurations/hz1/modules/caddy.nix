{sops, ...}: {
  sops.secrets."minioAwsCredentials" = {};

  services.caddy = {
    # package = pkgs.callPackage ../packages/caddy-with-plugins.nix { };
    enable = true;
    extraConfig = ''
      servers {
        metrics
      }
    '';
  };
}
