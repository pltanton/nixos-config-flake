{ pkgs, inputs, config, ... }: {
  home.file."${config.xdg.configHome}/electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';
}
