{
  stdenv,
  substituteAll,
  libxml2,
  wofi,
}:
stdenv.mkDerivation {
  name = "wofi-emoji";

  script = substituteAll {
    src = ./wofi-emoji.sh;
    isExecutable = true;
    inherit libxml2 wofi;
    inherit (stdenv) shell;
  };

  buildCommand = ''
    install -Dm755 $script $out/bin/wofi-emoji
  '';
}
