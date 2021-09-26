{ writeTextFile, writeText, writeShellScriptBin, symlinkJoin,
  xkbcomp, setxkbmap, xkblayout-state
}:

let
  diktor = writeTextFile {
    name = "diktor";
    text = builtins.readFile ./diktor.xkb;
    destination = "/symbols/diktor";
  };

  config-dvp-diktor = writeText "config-dvp-diktor" (builtins.readFile ./config_dvp_diktor.xkb);
  config-us-ru = writeText "diktor" (builtins.readFile ./config_us_ru.xkb);

  load-dvp-diktor-script = writeShellScriptBin "xkb-dvp-diktor" ''
    ${xkbcomp}/bin/xkbcomp -w0 -I${diktor} ${config-dvp-diktor} $DISPLAY 2> /dev/null
  '';

  load-us-ru-script = writeShellScriptBin "xkb-us-ru" ''
    ${xkbcomp}/bin/xkbcomp -w0 ${config-us-ru} $DISPLAY 2> /dev/null
  '';

  toggle-layouts = writeShellScriptBin "xkb-toggle" ''
    if ${xkblayout-state}/bin/xkblayout-state print %S | grep -q "diktor"; then
        ${load-us-ru-script}/bin/xkb-us-ru
    else
        ${load-dvp-diktor-script}/bin/xkb-dvp-diktor
    fi
  '';
in symlinkJoin {
  name = "myxkbutils";
  paths = [ load-dvp-diktor-script load-us-ru-script toggle-layouts ];
}
