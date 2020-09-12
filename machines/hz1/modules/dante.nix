{ config, pkgs, ... }:

{
  services = {
    openssh.enable = true;
    openssh.permitRootLogin = "yes";
    sshd.enable = true;
    shadowsocks = {
      enable = false;
      port = 2282;
      password = "test";
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
