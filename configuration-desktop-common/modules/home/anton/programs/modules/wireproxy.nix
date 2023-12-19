{ pkgs, lib, config, ... }:

let
  wireguardConfig = "${config.xdg.configHome}/wireproxy/wallet.wireguard";
  wireproxyConfig = pkgs.writeText "wireproxy.ini"
    (lib.generators.toINIWithGlobalSection { } {
      globalSection = { WGConfig = wireguardConfig; };
      sections = { 
        Socks5 = { BindAddress = "127.0.0.1:25344"; }; 
        
      };
    });
in {
  sops.secrets."wireguard/wallet" = { path = wireguardConfig; };

  systemd.user.services.wireproxy = {
    Unit = {
      Description = "Wireproxy local proxy";
      After = [ "sops-nix.service" ];
    };

    Install = { WantedBy = [ "default.target" ]; };

    Service = {
      ExecStart = "${pkgs.wireproxy}/bin/wireproxy -c ${wireproxyConfig} --silent";
    };
  };
}
