{ pkgs, ... }: {
  keyboard-layout-per-window = pkgs.stdenv.mkDerivation {
    name = "keyboard-layout-per-window";
    buildInputs = [
      (pkgs.python38.withPackages
        (pythonPackages: with pythonPackages; [ i3ipc ]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./keyboard-layout-per-window.py} $out/bin/keyboard-layout-per-window
      chmod +x $out/bin/keyboard-layout-per-window
    '';
  };
}
