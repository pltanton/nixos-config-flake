{
  config,
  pkgs,
  ...
}: {
  networking.firewall.allowedUDPPorts = [3128];
  networking.firewall.allowedTCPPorts = [3128];
  services = {
    openssh.enable = true;
    openssh.settings.PermitRootLogin = "yes";
    sshd.enable = true;
    _3proxy = {
      enable = true;
      usersFile = pkgs.writeText "3proxy_userfile" ''
        proxy:CR:$1$nPdrLpvx$d3gMiEibqWj2DZurlqtva0
      '';
      services = [
        {
          type = "proxy";
          bindAddress = "0.0.0.0";
          bindPort = 3128;
          auth = ["strong"];
          acl = [
            {
              rule = "allow";
              users = ["proxy"];
            }
            {rule = "deny";}
          ];
        }
      ];
    };

    dante = {
      enable = true;
      config = ''
        internal: ens3 port = 2282
        external: ens3

        user.privileged: root
        user.unprivileged: nobody

        logoutput: /var/log/dante.log
        socksmethod: username

        client pass {
            from: 0/0 to: 0/0
            log: error
        }
        socks pass {
            from: 0/0 to: 0/0
            log: error
        }
      '';
    };
  };
}
