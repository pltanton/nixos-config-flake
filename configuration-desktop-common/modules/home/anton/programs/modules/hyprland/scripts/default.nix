pkgs: config:

pkgs.stdenv.mkDerivation {
  name = "hyprland-scripts";
  src = ./.;
  buildInputs = with pkgs; [ light ddcutil ];
  installPhase = ''
    mkdir -p $out/bin;

    cp -v brightness.sh $out/bin/brightness
    substituteInPlace $out/bin/brightness \
      --replace light ${pkgs.light}/bin/light \
      --replace ddcutil ${pkgs.ddcutil}/bin/ddcutil;
    substituteAllInPlace $out/bin/brightness;
  '';
}
