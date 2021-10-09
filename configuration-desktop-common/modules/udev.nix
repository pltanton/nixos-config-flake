{ pkgs, ... }: {
  services.udev = {
    packages = [ pkgs.android-udev-rules ];
    extraRules = ''
      # Give priveleges to flash ATMega32U4 keyboard
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", MODE:="0666"

      #SUBSYSTEM=="drm", ACTION=="change", TAG+="systemd", ENV{SYSTEMD_WANTS}="autorandr.sevrice"
    '';
  };
}
