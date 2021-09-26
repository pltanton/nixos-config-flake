{ stdenv }:

stdenv.mkDerivation {
  name = "ir-toggle";
  src = ./src;
  buildPhase = ''
    gcc -o ir-toggle ir-toggle.c
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp ir-toggle $out/bin
  '';
}
