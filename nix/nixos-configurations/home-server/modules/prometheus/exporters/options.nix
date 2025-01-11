{lib, ...}:
with lib; {
  options.services.prometheus.custom-exporters = with types;
    mkOption {
      type = submodule {
        options = {
          smart = mkOption {
            type = submodule {
              options = {
                enable = mkOption {
                  type = bool;
                  default = false;
                  description = ''
                    Whether to enable SmartCtl scrapper timer.
                  '';
                };
                timer = mkOption {
                  type = str;
                  default = "10s";
                  example = "5s";
                  description = ''
                    Systemd timer value
                  '';
                };
              };
            };
          };
        };
      };
    };
}
