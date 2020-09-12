{ pkgs, ... }: {

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 3;
    shadow = true;

    shadowExclude = [
      "name = 'stalonetray'"
      "name = 'Screenshot'"
      "class_g = 'slop'"
      "class_i = 'polybar'"
      "class_i = 'tray'"
      "n:e:VirtualBox"
    ];

    opacityRule = [ "87:class_i ?= 'scratchpad'" "91:class_i ?= 'torrent'" ];

    blur = true;
    blurExclude = [ "class_g = 'slop'" "class_i = 'polybar'" ];
    #noDockBlur = true;

    extraOptions = ''
      xinerama-shadow-crop = true;
      unredir-if-possible = true;
      sw-opti = true;
      paint-on-overlay = true;
      wintypes:
      {
        tooltip = { fade = false; shadow = false; opacity = 1; };
      };
    '';
  };
}
