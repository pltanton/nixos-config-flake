{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.kanata;
in {
  options = {
    services.kanata = {
      enable = lib.mkEnableOption "kanata";

      config = lib.mkOption {
        type = lib.types.path;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "karabiner-elements" ];
    # services.karabiner-elements.enable = true;
    launchd.daemons = {
      kanata = {
        command = "sudo ${pkgs.kanata}/bin/kanata -c /etc/kanata/kanata.kbd";
        serviceConfig = {
          Label = "local.jtroo.kanata";
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/Library/Logs/Kanata/out.log";
          StandardErrorPath = "/Library/Logs/Kanata/error.log";
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        kanata
      ];
      etc = {
        "kanata/kanata.kbd".source = cfg.config;
        "sudoers.d/kanata".source =
          pkgs.runCommand "sudoers-kanata" {}
          # sh
          ''
            BIN="${pkgs.kanata}/bin/kanata"
            SHASUM=$(sha256sum "$BIN" | cut -d' ' -f1)
            cat << EOF > "$out"
            %admin ALL=(root) NOPASSWD: sha256:$SHASUM $BIN
            EOF
          '';
      };
    };
  };
}
