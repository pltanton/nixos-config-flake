{ config, pkgs, ... }:

let
  blackboxConfigFile = pkgs.writeText "blackboxConfig"
    (builtins.readFile ./blackbox_exporter_config.yml);
in {
  services = {
    prometheus = {
      exporters = {
        blackbox = {
          enable = true;
          configFile = blackboxConfigFile;
        };
      };

      scrapeConfigs = [{
        job_name = "blackbox";
        scrape_interval = "10s";
        metrics_path = "/probe";
        params = { module = [ "http_2xx" ]; };
        static_configs = [{
          targets = [
            "https://hass.kaliwe.ru"
            "https://bitwarden.kaliwe.ru"
            "https://gitea.kaliwe.ru"
            "https://jellyfin.kaliwe.ru"
            # "https://torrent.kaliwe.ru"
            "https://monitorrent.kaliwe.ru"
            "https://filestash.kaliwe.ru"
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
