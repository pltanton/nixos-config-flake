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

      gtkTheme = theme.gtkTheme;
      iconTheme = theme.iconTheme;
      cursorTheme = theme.cursorTheme;
      cursorSize = toString theme.cursorSize;

      base00_hex = base01-hex;
      base01_hex = base01-hex;
      base02_hex = base02-hex;
      base03_hex = base03-hex;
      base04_hex = base04-hex;
      base05_hex = base05-hex;
      base06_hex = base06-hex;
      base07_hex = base07-hex;
      base08_hex = base08-hex;
      base09_hex = base09-hex;
      base0A_hex = base0A-hex;
      base0B_hex = base0B-hex;
      base0C_hex = base0C-hex;
      base0D_hex = base0D-hex;
      base0E_hex = base0E-hex;
      base0F_hex = base0F-hex;

      inherit (theme) fontUIName;
    });
in {
  home.packages = lib.mkIf config.wayland.windowManager.hyprland.enable
    (with pkgs; [
      hyprpaper
      wl-clipboard

      clipman
      # For screenshots
      grim
      slurp
      swappy

      swaylock-fancy
      wofi-emoji
      pamixer

      # Scripts
      brightness
    ]);

  wayland.windowManager.hyprland = {
    extraConfig = ''
      source=${hyprctlConfig}
      source=${./keybinds.conf}
    '';
  };
}
