{ pkgs, secrets, ... }: {
  services.ddclient = {
    enable = true;
    passwordFile = "/root/ddclient-pass";
    username = "none";
    use = "web, web=checkip.dyndns.com/, web-skip='Current IP Address: '";
    ssl = true;
    server = "dynv6.com";
    domains = [ "kaliwe.ru" ];
    # configFile = "/root/ddclient.conf";
  };
}
