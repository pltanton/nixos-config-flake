{ nixpkgs, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."xn--eo8hej.kz" = {
      enableACME = true;
      forceSSL = true;

      root = "/var/www/blog";

      # locations."/" = {
      #   proxyWebsockets = true;
      #   proxyPass = "http://127.0.0.1:3030";
      # };
    };
  };
}
