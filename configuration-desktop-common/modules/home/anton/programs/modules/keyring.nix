{ pkgs, config, ... }: {
  home.packages = with pkgs; [ gnome.seahorse ];

  services = {
    gnome-keyring.enable = config.wayland.windowManager.sway.enable;
    gnome-keyring.components = [ "pkcs11" "secrets" "ssh" ];
  };
}
