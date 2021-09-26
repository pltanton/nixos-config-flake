{ pkgs, lib, ... }:
let
  wlgreetConfig = pkgs.writeText "wlgreet-sway.conf" ''
    exec "${lib.makeBinPath [ pkgs.greetd.wlgreet ]}/wlgreet --command sway; swaymsg exit"

    bindsym Mod4+shift+e exec swaynag \
    -t warning \
    -m 'What do you want to do?' \
    -b 'Poweroff' 'systemctl poweroff' \
    -b 'Reboot' 'systemctl reboot'

    include /etc/sway/config.d/*
  '';
in {
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;

  services.xserver = {
    enable = false;

    wacom.enable = true;

    layout = "us,us";
    xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput.enable = true;

    desktopManager.plasma5 = { enable = false; };
    # displayManager.sddm.enable = false;
    # displayManager.lightdm.enable = true;
    displayManager.gdm = {
      enable = false;
      wayland = true;
    };
    # displayManager.lightdm.enable = true;
    desktopManager.gnome = { enable = false; };
    desktopManager.xterm.enable = false;

    #   config = pkgs.lib.mkOverride 50 ''
    #     Section "Device"
    #         Identifier  "Intel Graphics"
    #         Driver      "intel"
    #         Option      "AccelMethod" "sna"
    #         Option      "TearFree" "true"
    #     EndSection

    #     Section "Device"
    #         Identifier  "Intel Graphics"
    #         Driver      "intel"
    #         Option      "Backlight"  "intel_backlight"
    #     EndSection
    #   '';
  };

  programs.sway.enable = false;
  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];

  programs.dconf.enable = true;
  environment.systemPackages =
    [ pkgs.gnome3.adwaita-icon-theme pkgs.qogir-icon-theme ];

  services.greetd = {
    enable = false;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [ pkgs.sway ]}/sway -c ${wlgreetConfig}";
        user = "greeter";
      };
    };
  };
}
