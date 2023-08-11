{ config, pkgs, inputs, ... }:
let
  catppuccinGitea = builtins.fetchurl {
    url =
      "https://github.com/catppuccin/gitea/releases/download/v0.2.1/catppuccin-gitea.tar.gz";
    sha256 = "40db2ede0335f360f177c733402593569524f5794616a7a97fd92be7203f86a2";
  };
in {
  services = {
    gitea = {
      enable = true;
      package = pkgs.unstable.gitea;
      database = {
        type = "postgres";
        passwordFile = "/secrets/gitea-database";
      };
      settings = {
        server = {
          DOMAIN = "gitea.kaliwe.ru";
          ROOT_URL = "https://gitea.kaliwe.ru";
          HTTP_PORT = 3003;
        };
        webhook = { ALLOWED_HOST_LIST = "external,loopback"; };
        # ui = {
        #   THEMES =
        #     "catppuccin-mocha-teal,catppuccin-latte-maroon,catppuccin-frappe-lavender,catppuccin-macchiato-flamingo";
        # };
      };
    };
  };

  system.activationScripts.installGiteaCustom.text = ''
    ${pkgs.busybox}/bin/tar -xzf ${catppuccinGitea} -C ${config.services.gitea.stateDir}/custom/public/css/
  '';

  services.caddy.virtualHosts."gitea.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:3003
  '';
}
