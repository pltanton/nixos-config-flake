{ stdenv, makeWrapper, fetchurl, jre, ... }:

stdenv.mkDerivation rec {
  name = "texlab-${version}";
  version = "v0.4.2";

  src = fetchurl {
    url = "https://github.com/latex-lsp/texlab/releases/download/${version}/texlab.jar";
    sha256 = "05gbdlcffix2v8hf93q6mc4s3lcr4qc70hrrzkmsd66cjn1nzayi";
  };

  buildInputs = [ makeWrapper ];
  phases = "installPhase";

  installPhase =
    ''
      mkdir -p $out/share/java
      cp $src $out/share/java/texlab.jar

      mkdir -p $out/bin
      makeWrapper ${jre}/bin/java $out/bin/texlab \
        --add-flags "-jar $out/share/java/texlab.jar"
    '';
}
