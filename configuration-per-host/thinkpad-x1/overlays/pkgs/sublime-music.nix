{ stdenv, fetchurl, python3Packages, gtk3, gobject-introspection, wrapGAppsHook }:

python3Packages.buildPythonApplication rec {
  name = "Sublime-Musics-${version}";
  version = "v0.9.0";

  src = fetchurl {
    url = "https://gitlab.com/sumner/sublime-music/-/archive/v0.9.0/sublime-music-${version}.tar.gz";
    sha256 = "0xvhsikgyzl36adj4zhjcjbn45m9zfl0ipkanfsym9pvrw64n8h4";
  };

  nativeBuildInputs =  [ gtk3 gobject-introspection wrapGAppsHook ];

  doCheck = false;

  makeWrapperArgs = [
    "--set GI_TYPELIB_PATH $GI_TYPELIB_PATH"
    "--prefix XDG_DATA_DIRS : $out/share"
    "--suffix XDG_DATA_DIRS : $XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH"
  ];

  propagatedBuildInputs = [
    python3Packages.bottle
    python3Packages.deepdiff
    python3Packages.deprecated
    python3Packages.fuzzywuzzy
    python3Packages.keyring
    python3Packages.PyChromecast
    python3Packages.pygobject3
    python3Packages.dateutil
    python3Packages.python-Levenshtein
    python3Packages.mpv
    python3Packages.pyyaml
    python3Packages.requests
  ];
}
