{
  pkgs,
  config,
  ...
}: let
  libykcs11BaseDir = "${pkgs.yubico-piv-tool}/lib";
  libykcs11Bin =
    if pkgs.stdenvNoCC.isDarwin
    then "libykcs11.dylib"
    else "libykcs11.so";
in {
  home.sessionVariables = {
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.ssh/ssh-agent.sock";
  };

  programs.fish.functions = {
    wallet-yubikey-agent =
      /*
      fish
      */
      ''
        echo "🔪 Killing old agent and socket..."
        pkill ssh-agent 2>/dev/null
        [ -S "$SSH_AUTH_SOCK" ] && rm -f "$SSH_AUTH_SOCK" 2>/dev/null

        echo "🌚 Starting ssh-agent..."
        set out (ssh-agent -P "${libykcs11BaseDir}/*" -a "$SSH_AUTH_SOCK") || echo $out

        echo "🔑 Adding Yubikey to ssh-agent..."
        set out (ssh-add -s ${libykcs11BaseDir}/${libykcs11Bin}) || echo $out
      '';
  };
}
