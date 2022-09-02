{ stdenv, substituteAll, light, ddcutil }:

stdenv.mkDerivation {
  name = "wofi-emoji";

  script = ./brightness.sh;

  buildCommand = ''
    install -Dm755 $script $out/bin/brightness
    substituteInPlace $out/bin/brightness \
                      --replace light ${light}/bin/light \
                      --replace ddcutil ${ddcutil}/bin/ddcutil
  '';
}
