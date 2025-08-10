_: {
  services.xray = {
    enable = true;
    settings = {
      log = {
        loglevel = "debug";
      };
      inbounds = [
        {
          listen = "@xrayxhttp.sock";
          protocol = "vless";
          settings = {
            clients = [
              {
                id = "6a369e27-31c2-448e-9d17-18e6b190daf3";
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
          settings = {};
        }
        {
          tag = "blocked";
          protocol = "blackhole";
          settings = {};
        }
      ];
      routing = {
        domainStrategy = "AsIs";
        rules = [
          {
            type = "field";
            ip = [
              "geoip:private"
            ];
            outboundTag = "blocked";
          }
        ];
      };
    };
  };

  # ADD FAKE STATIC SITE
  services.caddy.virtualHosts."sprintbox.kaliwe.ru".extraConfig = ''
    reverse_proxy /posts 127.0.0.1:2001 {
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

  services.caddy.virtualHosts."xui.sprintbox.pltanton.dev".extraConfig = ''
    reverse_proxy 127.0.0.1:2053
  '';
}
