{inputs, ...}: {
  imports = with inputs;
    [
      autobrowser.homeModules.default
    ]
    ++ inputs.self.lib.modulesDir ./.;

  nixpkgs.overlays = with inputs; [
    autobrowser.overlays.default
  ];
}
