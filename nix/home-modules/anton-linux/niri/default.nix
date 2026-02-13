{inputs, pkgs, ...}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      layout.border.enable = false;
    };
    config = ''
      input {
        keyboard {
          xkb {
            layout "us,ru"
            variant "dvorak,"
            options "grp:win_space_toggle,caps:escape"
          }
        }
        touchpad {
          tap
          natural-scroll
        }
      }

      include "${./keybinds.kdl}"

      window-rule {
        open-maximized-to-edges false
      }
    '';
  };
}
