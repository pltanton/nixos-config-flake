{ pkgs, ... }: {
  services.dbus = {
    enable = true;
    packages = with pkgs; [ gnome3.dconf ];
  };
}
