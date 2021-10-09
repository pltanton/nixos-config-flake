{ pkgs, ... }:
{
  home.packages = with pkgs; [ gnome3.seahorse ];

  services = {
    gnome-keyring.enable = true;
    gnome-keyring.components = [ "pkcs11" "secrets" "ssh" ];
  };
}
