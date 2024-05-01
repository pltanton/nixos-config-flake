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
          web.exposedPort = 9080;
          websecure.exposedPort = 9443;
        };
        ssl = {
          enabled = false;
          permanentRedirect = false;
        };
        additionalArguments = [
          "--providers.kubernetesingress.allowemptyservices=true"
          "--providers.kubernetesingress.allowexternalnameservices=true"
          "--providers.kubernetescrd.allowemptyservices=true"
          "--providers.kubernetescrd.allowexternalnameservices=true"
        ];
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

  services.caddy.virtualHosts."savor-dev.kaliwe.ru".extraConfig = ''
    reverse_proxy localhost:9080
  '';

  services.caddy.virtualHosts."anton.savor-dev.kaliwe.ru".extraConfig = ''
    handle /api/* {
      reverse_proxy 10.10.10.2:3301
    }


    handle {
      reverse_proxy 10.10.10.2:3000
    }
  '';

  environment.systemPackages = [ pkgs.k3s ];
}
