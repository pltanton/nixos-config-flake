{
  pkgs,
  lib,
  config,
  ...
}: {
  # sops.secrets."wireguard/wallet" = {path = wireguardConfig;};

  # systemd.user.services.wireproxy = {
  #   Unit = {
  #     Description = "Wireproxy local proxy";
  #     After = ["sops-nix.service"];
  #   };

  #   Install = {WantedBy = ["default.target"];};

  #   Service = {
  #     ExecStart = "${pkgs.wireproxy}/bin/wireproxy -c ${wireproxyConfig} --silent";
  #   };
  # };
}
