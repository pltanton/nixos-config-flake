{ nixpkgs, ... }: {
  services.caddy.virtualHosts."xn--eo8hej.kz".extraConfig = ''
    root * /var/www/blog
    file_server
  '';

  # services.caddy.virtualHosts."pltanton.dev".extraConfig = ''

  services.caddy.virtualHosts."pltanton.dev".extraConfig = ''
    @r1 path_regexp static ^(.*)/$
    handle @r1 {
      rewrite * /blog/{re.static.1}/index.html
    }

    @r2 path_regexp static ^(.*/[^./]+)$
    handle @r2 {
      rewrite * /blog/{re.static.1}/index.html
    }

    handle_path /* {
      rewrite * /blog/{path}
    }

    reverse_proxy localhost:9200 {
      @not_found status 403 404
      handle_response @not_found {
        rewrite * /blog/404.html
        reverse_proxy localhost:9200
      }
    }
  '';
}
