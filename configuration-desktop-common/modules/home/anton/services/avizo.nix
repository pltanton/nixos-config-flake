{ osConfig, config, lib, pkgs, ... }:
with lib;
let cfg = config.services.avizo;
in {
  options = {
    services.avizo = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable avizo.
        '';
      };
      config = mkOption { default = { }; };

      package = mkOption {
        type = types.package;
        default = pkgs.easyeffects;
        defaultText = literalExpression "pkgs.avizo";
        description = "The <literal>avizo</literal> package to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."avizo/config.ini" = {
      text = (lib.generators.toINI { } cfg.config);
    };

    systemd.user = {
      services.avizo = with osConfig.lib.stylix.colors; {
        Unit = {
          Description = "Volume/backlight OSD indicator";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          ConditionEnvironment = "WAYLAND_DISPLAY";
          Documentation = "man:avizo(1)";
        };

        Service = {
          Type = "simple";
          ExecStart = ''
            ${cfg.package}/bin/avizo-service
          '';
          Restart = "always";
        };

        Install = { WantedBy = [ "graphical-session.target" ]; };
      };
    };
  };
}
