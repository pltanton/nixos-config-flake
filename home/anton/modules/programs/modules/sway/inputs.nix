{ pkgs, ... }: {
  wayland.windowManager.sway.config.input = {
    "1:1:AT_Translated_Set_2_keyboard" = {
      xkb_layout = "us,ru";
      xkb_variant = "dvorak,";
      xkb_options = "grp:caps_toggle";
    };

    "51984:16982:Keebio_Keebio_Iris_Rev._4" = {
      xkb_layout = "us,ru";
      xkb_variant = ",";
      xkb_options = "grp:caps_toggle";
    };
  };
}