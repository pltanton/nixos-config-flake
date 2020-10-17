{ pkgs, ... }:
{
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    nextcloud-client.enable = true;
    udiskie.enable = true;
  };
}
