self: super: rec {
  wofi-emoji = super.callPackage ./wofi-emoji { };
  brightness = super.callPackage ./brightness { };
}
