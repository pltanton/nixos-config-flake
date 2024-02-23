{ config, lib, pkgs, ... }:


let
  blackboxConfig = pkgs.writeText "blackbox-config.yaml" (lib.generators.toYAML { } {
    modules.http_2xx = {
      prober = "http";
      timeout = "5s";
      http = {
        valid_http_versions = [ "HTTP/1.1" "HTTP/2.0" ];
        valid_status_codes = [ 200 401 ];
        method = "GET";
      };
    };
  });
in
{
  services = {
    prometheus = {
      exporters = {
        blackbox = {
          enable = true;
          configFile = blackboxConfig;
        };
      };

      scrapeConfigs = [{
        job_name = "blackbox";
        scrape_interval = "30s";
        metrics_path = "/probe";
        params = { module = [ "http_2xx" ]; };
        static_configs = [{
          targets = [
            "https://hass.kaliwe.ru"
            "https://bitwarden.kaliwe.ru"
            "https://gitea.kaliwe.ru"
            "https://jellyfin.kaliwe.ru"
            "https://monitorrent.kaliwe.ru"
            "https://nextcloud.kaliwe.ru"
            "https://s3.kaliwe.ru"
            "https://pltanton.dev"
          ];
        }];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "__param_target";
          }
          {
            source_labels = [ "__param_target" ];
            target_label = "instance";
          }
          {
            target_label = "__address__";
            replacement = "127.0.0.1:9115";
          }
        ];
      }];

      rules = [ (builtins.readFile ./rules/blackbox.yml) ];
    };
  };
}
