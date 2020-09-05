{ stdenv, python36, fetchFromGitHub, exiftool, ... }:

stdenv.mkDerivation rec {
  name = "phockup-${version}";
  version = "1.5.4";

  src = fetchFromGitHub {
    owner = "ivandokov";
    repo = "phockup";
    rev = version;
    sha256 = "0nwkp92aqvg6i8gb91wi0zm6nhffw8a1ii56jlqmmkskg99anqjr";
  };

  propagatedBuildInputs = [ python36 exiftool ];

  installPhase = ''
    mkdir -p $out/opt
    cp -r $src/* $out/opt

    mkdir -p $out/bin
    ln -s $out/opt/phockup.py $out/bin/phockup
  '';
}
