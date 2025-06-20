{inputs, ...}: {
  imports =
    [
      inputs.self.darwinModules.kanata
    ]
    ++ inputs.self.lib.modulesDir ./.;
}
