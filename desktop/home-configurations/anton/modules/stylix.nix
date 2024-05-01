{ pkgs, lib, inputs, ... }: {

  stylix = {
    targets.gtk.enable = false;
    targets.firefox.enable = false;
    targets.swaylock.enable = false;
    targets.rofi.enable = false;
    targets.waybar.enable = false;
    targets.avizo.enable = false;
    targets.vscode.enable = false;
    targets.hyprland.enable = false;
    targets.bemenu.enable = false;

    base16Scheme = lib.mkDefault "${inputs.base16-schemes}/catppuccin-macchiato.yaml";
    polarity = lib.mkDefault "dark";
    cursor = {
      # package = pkgs.master.phinger-cursors;
      # name = lib.mkDefault "phinger-cursors-light";
      package = pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Modern-Classic";
      size = 24;
    };
  };

  specialisation.light.configuration.stylix = {
    # base16Scheme = "${inputs.base16-schemes}/catppuccin-latte.yaml";
    # polarity = "light";
    # cursor.name = "phinger-cursors";
  };
}
