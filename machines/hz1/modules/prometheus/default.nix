{ config, pkgs, ... }:

{
  imports = [ ./blackbox.nix ];

  services = {
    prometheus = {
      enable = true;
      alertmanager.enable = false;
      alertmanager.configText = ''
        route:
          group_wait: 20s        #  Частота
          group_interval: 20s   #  уведомлений
          repeat_interval: 60s  #  в телеграм
          group_by: ['alertname', 'cluster', 'service']
          receiver: alertmanager-bot

        receivers:
        - name: alertmanager-bot
          webhook_configs:
          - send_resolved: true
            url: 'http://ip_telegram_bot:8080'
      '';


      exporters = {
        node.enable = true;
      };

      scrapeConfigs = [
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
