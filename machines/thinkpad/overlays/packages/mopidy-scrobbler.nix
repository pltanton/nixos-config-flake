{ stdenv, fetchFromGitHub, python3Packages, mopidy }:

python3Packages.buildPythonApplication rec {
  pname = "Mopidy-Scrobbler";
  version = "2.0.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0s8xx4hf3dr76wml5rvr7ys6dh7zidipdx2flbsm0nfd0ciyj494";
  };

  doCheck = false;

  propagatedBuildInputs = with python3Packages; [
    mopidy
    pylast
  ];
}
