{ config, pkgs, ... }:

{
  networking.firewall.allowedUDPPorts = [ 3128 ];
  networking.firewall.allowedTCPPorts = [ 3128 ];
  services = {
    openssh.enable = true;
    openssh.permitRootLogin = "yes";
    sshd.enable = true;
    _3proxy = {
      enable = true;
      services = [{
        type = "proxy";
        bindAddress = "0.0.0.0";
        bindPort = 3128;
        auth = [ "none" ];
      }];
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
