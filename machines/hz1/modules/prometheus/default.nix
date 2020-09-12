{ config, pkgs, ... }:

let
  blackboxConfigFile = pkgs.writeText "blackboxConfig" (builtins.readFile ./blackbox_exporter_config.yml);
in {
  services = {
    prometheus = {
      enable = true;
      exporters = {
        node.enable = true;
        blackbox = {
          enable = true;
          configFile = blackboxConfigFile;
        };
      };

      scrapeConfigs = [
        {
          job_name = "blackbox";
          scrape_interval = "10s";
          metrics_path = "/probe";
          params = {
            module = [ "http_2xx" ];
          };
          static_configs = [{
            targets = [
              "https://hass.kaliwe.ru"
              "https://bitwarden.kaliwe.ru"
              "https://gitea.kaliwe.ru"
              "https://jellyfin.kaliwe.ru"
              "https://torrent.kaliwe.ru"
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
        }
        {
          job_name = "node";
          scrape_interval = "10s";
          static_configs = [{ targets = [ "localhost:9100" ]; }];
        }
        {
          job_name = "hass";
          scrape_interval = "10s";
          metrics_path = "/api/prometheus";
          scheme = "https";
          bearer_token =
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI3MTFkMjAyYTI0NTM0MmI5ODUxNzM3NTc0MGI0Zjc0ZCIsImlhdCI6MTU3MjkxMjY0MCwiZXhwIjoxODg4MjcyNjQwfQ.NAyrG4kOgR4QV-FqxfQy3fn-lxVIZRwlmFN3jwq1nPU";
          static_configs = [{ targets = [ "hass.kaliwe.ru:443" ]; }];
        }
      ];
    };
  };
}
