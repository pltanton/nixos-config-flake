{ pkgs, lib, ... }:

let
  wireproxyConfig = lib.generators.toINIWithGlobalSection { } {
    globalSection = { WGConfig = "test"; };
    Socks5 = { BindAddress = "127.0.0.1:25344"; };
  };
in {
  sops.secrets."wireguard/wallet" = { };

  systemd.user.services.wireproxy = {
    Unit = { Description = "Wireproxy local proxy"; };

    Install = { WantedBy = [ "default.target" ]; };

    Service = { ExecStart = "${pkgs.wireproxy}/bin/wireproxy -c ${wireproxyConfig}"; };
  };
}
