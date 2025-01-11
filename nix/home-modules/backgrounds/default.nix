{lib, ...}: {
  options.backgrounds = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    default = with builtins;
      mapAttrs
      (name: _value: ./. + "/${name}")
      (removeAttrs (readDir ./.) ["default.nix"]);
  };
}
