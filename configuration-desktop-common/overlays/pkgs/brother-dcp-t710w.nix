{ pkgs, pkgsi686Linux, stdenv, fetchurl, dpkg, makeWrapper, coreutils
, ghostscript, gnugrep, gnused, which, perl, lib }:

let
  model = "dcpt710w";
  version = "1.0.0-0";
  src = fetchurl {
    url =
      "https://download.brother.com/welcome/dlf103622/${model}pdrv-${version}.i386.deb";
    sha256 = "12vr9j0y97am8f0qvpp87531i67p704pb65f7928vv8yw6l6j3sj";
  };
  reldir = "opt/brother/Printers/${model}/";

in rec {
  driver = pkgsi686Linux.stdenv.mkDerivation rec {
    inherit src version;
    name = "${model}drv-${version}";

    nativeBuildInputs = [ dpkg makeWrapper ];

    unpackPhase = "dpkg-deb -x $src $out";

    installPhase = ''
        dir="$out/${reldir}"
        substituteInPlace $dir/lpd/filter_${model} \
          --replace /usr/bin/perl ${perl}/bin/perl \
          --replace "BR_PRT_PATH =~" "BR_PRT_PATH = \"$dir\"; #" \
          --replace "PRINTER =~" "PRINTER = \"${model}\"; #"
        wrapProgram $dir/lpd/filter_${model} \
          --prefix PATH : ${
            stdenv.lib.makeBinPath [
              coreutils
              ghostscript
              gnugrep
              gnused
              which
            ]
          }
      # need to use i686 glibc here, these are 32bit proprietary binaries
      # patchelf --set-interpreter  "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      #    $dir/lpd/brdcpt710wfilter

      mv $dir/lpd/brdcpt710wfilter $dir/lpd/brdcpt710wfilter-unwrapped
      echo '#!/usr/bin/env sh \n exec $(cat $NIX_CC/nix-support/dynamic-linker) dir/lpd/brdcpt710wfilter-unwrapped $@' > $dir/lpd/brdcpt710wfilter
      chmod +x $dir/lpd/brdcpt710wfilter
    '';

    meta = {
      description = "Brother ${lib.strings.toUpper model} driver";
      homepage = "http://www.brother.com/";
      license = stdenv.lib.licenses.unfree;
      platforms = [ "x86_64-linux" "i686-linux" ];
      maintainers = [ stdenv.lib.maintainers.steveej ];
    };
  };

  cupswrapper = stdenv.mkDerivation rec {
    inherit version src;
    name = "${model}cupswrapper-${version}";

    nativeBuildInputs = [ dpkg makeWrapper ];

    unpackPhase = "dpkg-deb -x $src $out";

    installPhase = ''
      basedir=${driver}/${reldir}
      dir=$out/${reldir}
      substituteInPlace $dir/cupswrapper/brother_lpdwrapper_${model} \
        --replace /usr/bin/perl ${perl}/bin/perl \
        --replace "basedir =~" "basedir = \"$basedir\"; #" \
        --replace "PRINTER =~" "PRINTER = \"${model}\"; #"
      wrapProgram $dir/cupswrapper/brother_lpdwrapper_${model} \
        --prefix PATH : ${stdenv.lib.makeBinPath [ coreutils gnugrep gnused ]}
      mkdir -p $out/lib/cups/filter
      mkdir -p $out/share/cups/model
      ln $dir/cupswrapper/brother_lpdwrapper_${model} $out/lib/cups/filter
      ln $dir/cupswrapper/brother_${model}_printer_en.ppd $out/share/cups/model
    '';

    meta = {
      description = "Brother ${lib.strings.toUpper model} CUPS wrapper driver";
      homepage = "http://www.brother.com/";
      license = stdenv.lib.licenses.gpl2;
      platforms = [ "x86_64-linux" "i686-linux" ];
      maintainers = [ stdenv.lib.maintainers.steveej ];
    };
  };
}
