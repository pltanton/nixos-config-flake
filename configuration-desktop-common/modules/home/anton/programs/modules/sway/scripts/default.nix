pkgs: config:

pkgs.stdenv.mkDerivation {
  name = "sway-scripts";
  src = ./.;
  buildInputs = with pkgs; [ light ddcutil ];
  installPhase = ''
    mkdir -p $out/bin;

    cp -v brightness.sh $out/bin/brightness
    substituteInPlace $out/bin/brightness \
      --replace light ${pkgs.light}/bin/light \
      --replace ddcutil ${pkgs.ddcutil}/bin/ddcutil;
    substituteAllInPlace $out/bin/brightness;

    cp -v fadeout.sh $out/bin/fadeout
    substituteInPlace $out/bin/fadeout \
      --replace swaymsg ${config.wayland.windowManager.sway.package}/bin/swaymsg;
    substituteAllInPlace $out/bin/fadeout;

    cp -v workspacefade.sh $out/bin/workspacefade
    substituteInPlace $out/bin/workspacefade \
      --replace swaymsg ${config.wayland.windowManager.sway.package}/bin/swaymsg;
    substituteAllInPlace $out/bin/workspacefade;
  '';
}
