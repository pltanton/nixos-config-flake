{ config, pkgs, ... }:
let
  # inherit (pkgs) howdy ir-toggle;
  # pam-rule =
  #   "auth sufficient ${pkgs.pam-python}/lib/security/pam_python.so ${pkgs.howdy}/lib/security/howdy/pam.py";
in {
  # environment.systemPackages = [ howdy ir-toggle ];

  # environment.etc."howdy.ini".source = pkgs.runCommand "config.ini" { } ''
  #   cat ${pkgs.howdy}/lib/security/howdy/config.ini > $out
  #   substituteInPlace $out --replace 'device_path = none' 'device_path = /dev/video2'
  # '';

  # powerManagement.resumeCommands = "${pkgs.ir-toggle}/bin/ir-toggle on";
  # services.udev.extraRules = ''
  #   ATTRS{idVendor}=="04f2", ATTRS{idProduct}=="b67c", ACTION=="add", RUN+="${pkgs.ir-toggle}/bin/ir-toggle on"
  # '';

  # security.pam.services = {
  #   sudo.text = pam-rule; # Sudo
  #   login.text = pam-rule; # User login
  #   polkit-1.text = pam-rule; # PolKit
  # };
}
