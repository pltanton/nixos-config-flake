{ stdenv, fetchFromGitHub, python3Packages, mopidy }:

python3Packages.buildPythonApplication rec {
  pname = "Mopidy-Local";
  version = "3.1.1";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "13m0iz14lyplnpm96gfpisqvv4n89ls30kmkg21z7v238lm0h19j";
  };

  doCheck = false;

  propagatedBuildInputs = [
    mopidy
    python3Packages.uritools
  ];
}
