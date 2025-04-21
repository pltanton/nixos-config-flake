{lib, ...}: {
  networking = {firewall = {allowedTCPPorts = [443 80];};};
  services.caddy.enable = true;

  # Let nginx listen on different ports because the main ports are used by caddy
  services.nginx = {
    enable = false;
    defaultHTTPListenPort = lib.mkForce 4080;
    defaultSSLListenPort = lib.mkForce 4443;
  };
}
