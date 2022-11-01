{ config, lib, pkgs, inputs, ... }:
let
  grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
    mkdir -p ~/Screenshots
    FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
    grim -g "$(slurp)" - | swappy -f - -o "$FILE_PATH"
    wl-copy -t image/png < $FILE_PATH
  '';

  theme = config.lib.base16.theme;

  hyprctlConfig = with theme;
    pkgs.substituteAll ({
      src = ./hyprland.conf;

      glib = "${pkgs.glib}/bin/gsettings";
      brightness = "${pkgs.brightness}/bin/brightness";
      xprop = "${pkgs.xorg.xprop}/bin/xprop";

      gtkTheme = theme.gtkTheme;
      iconTheme = theme.iconTheme;
      cursorTheme = theme.cursorTheme;
      cursorSize = toString theme.cursorSize;

      base0 = base00-hex;
      base1 = base01-hex;
      base2 = base02-hex;
      base3 = base03-hex;
      base4 = base04-hex;
      base5 = base05-hex;
      base6 = base06-hex;
      base7 = base07-hex;
      base8 = base08-hex;
      base9 = base09-hex;
      baseA = base0A-hex;
      baseB = base0B-hex;
      baseC = base0C-hex;
      baseD = base0D-hex;
      baseE = base0E-hex;
      baseF = base0F-hex;

      inherit (theme) fontUIName;
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
