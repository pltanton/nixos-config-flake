# Original: https://github.com/kylesferrazza/nix/blob/master/overlay/bitwarden-rofi/default.nix
{ stdenv, fetchFromGitHub, makeWrapper, unixtools, lib, xsel, xclip
, wl-clipboard, xdotool, bitwarden-cli, rofi, jq, keyutils }:

let
  bins = [
    jq
    bitwarden-cli
    unixtools.getopt
    rofi
    xsel
    xclip
    wl-clipboard
    xdotool
    keyutils
  ];
in stdenv.mkDerivation {
  pname = "bitwarden-rofi";
  version = "git-2019-11-08";

  src = fetchFromGitHub {
    owner = "kylesferrazza";
    repo = "bitwarden-rofi";
    rev = "2f3d5ad37d8a0905c264ede81f6e9cd57ff786af";
    sha256 = "0g70zia8h31sqf25qla6wss7pmcg5q6va3v9y967806g1xi47hms";
  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p "$out/bin"
    install -Dm755 "bwmenu" "$out/bin/bwmenu"
    install -Dm755 "lib-bwmenu" "$out/bin/lib-bwmenu"
    install -Dm755 -d "$out/usr/share/doc/bitwarden-rofi"
    install -Dm755 -d "$out/usr/share/doc/bitwarden-rofi/img"
    install -Dm644 "README.md" "$out/usr/share/doc/bitwarden-rofi/README.md"
    install -Dm644 img/* "$out/usr/share/doc/bitwarden-rofi/img/"
    wrapProgram "$out/bin/bwmenu" --prefix PATH : ${lib.makeBinPath bins}
  '';

  meta = with lib; {
    license = licenses.gpl3;
    platforms = platforms.linux;
    homepage = "https://github.com/mattydebie/bitwarden-rofi";
    maintainers = with maintainers; [ kylesferrazza ];
  };

}
