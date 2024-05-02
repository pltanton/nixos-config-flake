{
  config,
  pkgs,
  ...
}: {
  imports = [./blackbox.nix];

  services = {
    prometheus = {
      enable = true;
      alertmanager.enable = false;
      alertmanager.configText = ''
        route:
          group_wait: 20s
          group_interval: 20s
          repeat_interval: 60s
          group_by: ['alertname', 'cluster', 'service']
          receiver: alertmanager-bot

        receivers:
        - name: alertmanager-bot
          webhook_configs:
          - send_resolved: true
            url: 'http://ip_telegram_bot:8080'
      '';

      exporters = {node.enable = true;};

      scrapeConfigs = [
        {
          job_name = "node";
          scrape_interval = "10s";
          static_configs = [{targets = ["localhost:9100" "10.10.10.10:9100"];}];
        }
        {
          job_name = "caddy";
          scrape_interval = "15s";
          static_configs = [{targets = ["localhost:2019"];}];
        }
      ];
    };
  };
}
