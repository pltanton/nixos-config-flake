{inputs, ...}: {
  home.packages = [
    inputs.hyprdynamicmonitors.packages.x86_64-linux.default
  ];
  home.hyprdynamicmonitors = {
    enable = true;
    config = ''
      [general]
      destination = "$HOME/.config/hypr/monitors.conf"
      debounce_time_ms = 1500
    '';
  };
}
