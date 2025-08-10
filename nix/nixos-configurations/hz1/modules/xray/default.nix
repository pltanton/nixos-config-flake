_: {
  services.xray = {
    enable = true;
    settings = {
      log = {
        loglevel = "warning";
      };
      inbounds = [
        # {
        #   protocol = "vless";
        #   port = 20001;
        #   settings = {
        #     clients = [
        #       {
        #         id = "fcbedce3-a331-4bd6-9f96-45113c30a844";
        #         email = "anon@anon.com";
        #       }
        #     ];
        #     decryption = "none";
        #   };
        #   streamSettings = {
        #     network = "raw";
        #     security = "reality";
        #     realitySettings = {
        #       dest = "mirror.thunderhosting.cloud:443";
        #       serverNames = ["mirror.thunderhosting.cloud, www.mirror.thunderhosting.cloud"];
        #       shortIds = [""];
        #     };
        #   };
        # }

        {
          listen = "/dev/shm/Xray-VLESS-gRPC.socket,0666";
          protocol = "vless";
          settings = {
            clients = [
              {
                id = "fcbedce3-a331-4bd6-9f96-45113c30a844";
                email = "anon@anon.com";
              }
            ];
            decryption = "none";
          };
          streamSettings = {
            network = "grpc";
            grpcSettings = {
              serviceName = "ChillService";
            };
          };
        }

        {
          listen = "@xrayxhttp.sock";
          protocol = "vless";
          settings = {
            clients = [
              {
                id = "fcbedce3-a331-4bd6-9f96-45113c30a844";
                email = "anon@anon.com";
              }
            ];
            decryption = "none";
          };
          streamSettings = {
            security = "none";
            network = "xhttp";
            xhttpSettings = {
              path = "/topics";
            };
          };
        }
      ];
      outbounds = [
        {
          tag = "direct";
          protocol = "freedom";
        }
        {
          tag = "block";
          protocol = "blackhole";
        }
      ];
      routing = {
        domainStrategy = "IPIfNonMatch";
        rules = [
          {
            type = "field";
            ip = [
              "geoip:private"
            ];
            outboundTag = "block";
          }
          {
            type = "field";
            protocol = [
              "bittorrent"
            ];
            outboundTag = "block";
          }
        ];
      };
    };
  };

  # ADD FAKE STATIC SITE
  services.caddy.virtualHosts."kaliwe.ru".extraConfig = ''
    @grpc {
      protocol grpc
      path /ChillService/*
    }
    reverse_proxy @grpc unix//dev/shm/Xray-VLESS-gRPC.socket {
      flush_interval -1
      transport http {
        versions h2c
      }
    }
    reverse_proxy /topics/* unix/@xrayxhttp.sock {
      flush_interval -1
      transport http {
        versions h2c 2
      }
    }
  '';

  virtualisation.oci-containers.containers.xui = {
    image = "ghcr.io/mhsanaei/3x-ui:latest";
    ports = ["127.0.0.1:2053:2053" "57625:57625"];
    volumes = [
      "/root/x-ui:/etc/x-ui"
    ];
  };

  services.caddy.virtualHosts."xui.hz1.pltanton.dev".extraConfig = ''
    reverse_proxy 127.0.0.1:2053
  '';
}
