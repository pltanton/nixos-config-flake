{ pkgs, lib, config, secrets, ... }:

let
  traefikConfig = builtins.toJSON {
    apiVersion = "helm.cattle.io/v1";
    kind = "HelmChartConfig";
    metadata = {
      name = "traefik";
      namespace = "kube-system";
    };
    spec = {
      valuesContent = builtins.toJSON {
        ports = {
          web.exposedPort = 8080;
          websecure.exposedPort = 8443;
        };
        ssl = {
          enabled = false;
          permanentRedirect = false;
        };
      };
    };
  };
in {
  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall.allowedTCPPorts = [ 6443 ];
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = toString [
      # "--kubelet-arg=v=4" # Optionally add additional args to k3s
      # "--disable=traefik"
      "--node-ip=195.201.150.251"
    ];
  };

  system.activationScripts.installK3SConfigs.text = ''
    mkdir -p /var/lib/rancher/k3s/server/manifests/
    echo '${traefikConfig}' > "/var/lib/rancher/k3s/server/manifests/traefik-config.yaml"
  '';

  environment.etc = {
    "rancher/k3s/registries.yaml" = {
      text = builtins.toJSON {
        mirrors = {
          "gitea.kaliwe.ru" = { endpoint = [ "https://gitea.kaliwe.ru" ]; };
        };
        configs = {
          "gitea.kaliwe.ru" = {
            auth = {
              username = "pltanton";
              password = secrets.gitea;
            };
          };
        };
      };
      mode = "0440";
    };
  };

  services.caddy.virtualHosts."savor.kaliwe.ru".extraConfig = ''
    reverse_proxy localhost:8080
  '';

  services.caddy.virtualHosts."savor-dev.kaliwe.ru".extraConfig = ''
    reverse_proxy localhost:3000
  '';

  services.caddy.virtualHosts."anton.savor-dev.kaliwe.ru".extraConfig = ''
    reverse_proxy 10.10.10.2:3000
  '';

  services.caddy.virtualHosts."savor-dev-anton.kaliwe.ru".extraConfig = ''
    reverse_proxy 10.10.10.2:3000
  '';

  environment.systemPackages = [ pkgs.k3s ];
}
