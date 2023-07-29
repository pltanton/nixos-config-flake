{ nixpkgs, ... }: {
  services.caddy.virtualHosts."xn--eo8hej.kz".extraConfig = ''
    root * /var/www/blog
    file_server
  '';
}
