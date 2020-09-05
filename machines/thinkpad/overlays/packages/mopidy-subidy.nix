{ stdenv, fetchFromGitHub, python3Packages, mopidy }:

let
  py-sonic = python3Packages.buildPythonPackage rec {
    pname = "py-sonic";
    version = "0.7.7";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "0wh2phg8h02a6vlpqd0widd6g8ng142vzmk8hpyx0bnwn2i45sjc";
    };

    doCheck = false;
  };
in python3Packages.buildPythonApplication rec {
  pname = "Mopidy-Subidy";
  version = "1.0.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0qnill5zz6cx5hwk43rg6k7624alllh8r1g47rkkqzvz45xw6rwz";
  };

  doCheck = false;

  propagatedBuildInputs = [
    mopidy
    python3Packages.uritools
    py-sonic
  ];
}
