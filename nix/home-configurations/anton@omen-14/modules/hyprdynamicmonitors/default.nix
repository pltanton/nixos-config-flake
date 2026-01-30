{inputs, ...}: {
  home.packages = [
    inputs.hyprdynamicmonitors.packages.x86_64-linux.default
  ];

  home.hyprdynamicmonitors = {
    enable = true;
    configFile = ./config.toml;
    extraFiles = {
      "hyprdynamicmonitors/hyprconfigs/office-dell.go.tmpl" = ./office-dell.go.tmpl;
      "hyprdynamicmonitors/hyprconfigs/office-xiaomi-tv.go.tmpl" = ./office-xiaomi-tv.go.tmpl;
      "hyprdynamicmonitors/hyprconfigs/default.go.tmpl" = ./default.go.tmpl;
    };
    installExamples = false;
    extraFlags = ["--enable-lid-events"];
  };
}
