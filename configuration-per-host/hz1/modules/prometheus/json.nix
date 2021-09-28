{ config, pkgs, ... }:

let
  jsonConfigFile =
    pkgs.writeText "jsonConfig" (builtins.readFile ./json_config.yml);
in {
  services.prometheus = {
    exporters = {
      json = {
        enable = true;
        configFile = jsonConfigFile;
      };
    };

    scrapeConfigs = [{
      job_name = "json_sportlife";
      scrape_interval = "1m";
      metrics_path = "/probe";
      static_configs = [{
        targets = [
          "https://sync.sportlifeclub.ru/handh/api/v1/club/1"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/3"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/5"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/6"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/9"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/10"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/12"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/13"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/14"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/15"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/16"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/17"
          "https://sync.sportlifeclub.ru/handh/api/v1/club/18"
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
          replacement = "127.0.0.1:7979";
        }
      ];
    }];
  };
}
