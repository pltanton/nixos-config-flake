{ osConfig, config, lib, pkgs, inputs, ... }:
let
  grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
    mkdir -p ~/Screenshots
    FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
    grim -g "$(slurp)" - | swappy -f - -o "$FILE_PATH"
    wl-copy -t image/png < $FILE_PATH
  '';

  hyprctlConfig = with osConfig.stylix.palette;
    pkgs.substituteAll ({
      src = ./hyprland.conf;

      glib = "${pkgs.glib}/bin/gsettings";
      brightness = "${pkgs.brightness}/bin/brightness";
      xprop = "${pkgs.xorg.xprop}/bin/xprop";

      gtkTheme = config.gtk.theme.name;
      iconTheme = config.gtk.iconTheme.name;
      cursorTheme = config.home.pointerCursor.name;
      cursorSize = toString config.home.pointerCursor.size;

      base0 = base00;
      base1 = base01;
      base2 = base02;
      base3 = base03;
      base4 = base04;
      base5 = base05;
      base6 = base06;
      base7 = base07;
      base8 = base08;
      base9 = base09;
      baseA = base0A;
      baseB = base0B;
      baseC = base0C;
      baseD = base0D;
      baseE = base0E;
      baseF = base0F;

      # TODO Replace it with stylix
      gradient0 = "8fbcbb";
      gradient1 = "88c0d0";
      gradient2 = "81a1c1";
      gradient3 = "5e81ac";
    });
in {
  home.packages = lib.mkIf config.wayland.windowManager.hyprland.enable
    (with pkgs; [
      hyprpaper
      wl-clipboard

      clipman

      swaylock-fancy
      wofi-emoji
      pamixer

      # Scripts
      brightness
      screenshot
    ]);

  wayland.windowManager.hyprland = {
    extraConfig = ''
      source=${hyprctlConfig}
      source=${./keybinds.conf}
    '';
  };
}
