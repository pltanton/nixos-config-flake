{ osConfig, config, lib, pkgs, ... }:
with lib;
let cfg = config.services.wob;
in {
  options = {
    services.wob = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable wob.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = { WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock"; };

    systemd.user = {

      services.wob = with osConfig.lib.stylix.colors; {
        Unit = {
          Description =
            "A lightweight overlay volume/backlight/progress/anything bar for Wayland";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" "wob.socket" ];
          Requires = "wob.socket";
          ConditionEnvironment = "WAYLAND_DISPLAY";
          Documentation = "man:wob(1)";
        };

        Service = {
          Type = "simple";
          StandardInput = "socket";
          ExecStart = ''
            ${pkgs.wob}/bin/wob \
                        --background-color #${base00}C8 \
                        --border-color #${base05}FF \
                        --bar-color #${base05}FF \
                        -O '*'
          '';
          Restart = "always";
        };

        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      sockets.wob = {
        Unit = { Description = "Wob socket to listen"; };

        Socket = {
          ListenFIFO = "%t/wob.sock";
          SocketMode = "0600";
        };

        Install = { WantedBy = [ "sockets.target" ]; };
      };

    };
  };
}
