{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    wacom.enable = true;

    layout = "us,ru";
    #xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput.enable = true;

    displayManager.lightdm.enable = true;

    config = pkgs.lib.mkOverride 50 ''
      Section "Device"
          Identifier  "Intel Graphics"
          Driver      "intel"
          Option      "AccelMethod" "sna"
          Option      "TearFree" "true"
      EndSection

      Section "Device"
          Identifier  "Intel Graphics"
          Driver      "intel"
          Option      "Backlight"  "intel_backlight"
      EndSection
    '';
  };

}
