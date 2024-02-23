{ pkgs, lib, inputs, ... }: {

  stylix = {
    base16Scheme = lib.mkDefault "${inputs.base16-schemes}/catppuccin-macchiato.yaml";

    targets.gtk.enable = true;
    targets.gnome.enable = true;
    targets.firefox.enable = true;

    targets.swaylock.enable = false;
    targets.rofi.enable = false;
    targets.waybar.enable = false;
    targets.avizo.enable = false;
    targets.vscode.enable = false;
    targets.hyprland.enable = false;
    targets.k9s.enable = false;

    polarity = lib.mkDefault "dark";

    cursor = {
      package = pkgs.master.phinger-cursors;
      name = lib.mkDefault "phinger-cursors-light";
    };


  };

  specialisation.light.configuration.stylix = {
    base16Scheme = "${inputs.base16-schemes}/catppuccin-latte.yaml";
    polarity = "light";
    cursor.name = "phinger-cursors-dark";
  };
}
