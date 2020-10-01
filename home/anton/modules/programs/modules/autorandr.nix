{ pkgs, ... }: {
  programs.autorandr = {
    enable = false;
    hooks.postswitch = {
      reload-background = "systemctl --user restart random-background";
      reload-dpi = ''
        if [[ $AUTORANDR_CURRENT_PROFILE == *"-hidpi" ]]; then
          echo Xft.dpi: 192 | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        else
          echo Xft.dpi: 96 | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        fi
        systemctl --user restart taffybar
      '';
    };
  };
}
