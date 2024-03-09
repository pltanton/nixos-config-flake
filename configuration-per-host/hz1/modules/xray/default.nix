{pkgs, ...}:
{

  services.xray = {
    enable = true;
    settings = {


      log = {
        loglevel = "warning";
      };
      inbounds = [
        {
          port = 2001;
          listen = "127.0.0.1";
          protocol = "vless";
          settings = {
            clients = [
              {
                id = "";
                email = "putin@huilo.com";
              }
            ];
            decryption = "none";
          };
          streamSettings = {
            security = "none";
            network = "h2";
            httpSettings = {
              path = "/posts";
              host = [
                "kaliwe.ru"
              ];
            };
          };
        }
      ];
      outbounds = [
        {
          tag = "direct";
          protocol = "freedom";
          settings = { };
        }
        {
          tag = "blocked";
          protocol = "blackhole";
          settings = { };
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
  services.caddy.virtualHosts."kaliwe.ru".extraConfig = ''
    reverse_proxy /posts http://127.0.0.1:2001 {
      transport http {
        version h2c
      }
    }

    redir https://pltanton.dev
  '';
}
}