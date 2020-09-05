pkgs:

let secrets = import ../../secrets.nix;
in {
  dbus.packages = with pkgs; [ gnome3.dconf ];
  dbus.enable = true;
  autorandr.enable = false;
  openssh = {
    enable = true;
    forwardX11 = true;
  };
  blueman.enable = true;

  printing.enable = true;
  printing.drivers = [ pkgs.gutenprint ];
  avahi.enable = true;
  avahi.nssmdns = true;

  pcscd.enable = true;
  upower.enable = true;
  saned.enable = true;
  postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
      host  all  all 0.0.0.0/0 md5
    '';
  };

  gnome3.gnome-keyring.enable = true;

  xserver = {
    enable = true;

    wacom.enable = true;

    desktopManager.xterm = { enable = true; };

    layout = "us,ru";
    #xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput.enable = true;

    displayManager.lightdm = { enable = true; };
    config = ''
      Section "InputClass"
          Identifier "system-keyboard"
          MatchIsKeyboard "on"
          Option "XkbLayout" "cz,us"
          Option "XkbModel" "pc104"
          Option "XkbVariant" ",dvorak"
          Option "XkbOptions" "grp:alt_shift_toggle"
      EndSection
    '';
  };

  udev = {
    packages = [ pkgs.android-udev-rules ];
    extraRules = ''
      # Give priveleges to flash ATMega32U4 keyboard
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", MODE:="0666"

      #SUBSYSTEM=="drm", ACTION=="change", TAG+="systemd", ENV{SYSTEMD_WANTS}="autorandr.sevrice"
    '';
  };

  mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-scrobbler
      mopidy-subidy
      mopidy-iris
      mopidy-mpd
    ];
    configuration = ''
      [audio]
      mixer=none
      output=pulsesink server=127.0.0.1

      [subidy]
      enabled=true
      url=https://navidrome.kaliwe.ru
      username=anton
      password=${secrets.subidy}

      [scrobbler]
      enabled=true
      username=plotnikovanton
      password=${secrets.lastfm}

      [mpd]
      hostname=::
    '';
  };

}
