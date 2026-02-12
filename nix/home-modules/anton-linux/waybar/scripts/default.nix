{pkgs, ...}: {
  mediaplayer = pkgs.writeShellApplication {
    name = "mediaplayer";
    runtimeInputs = with pkgs; [playerctl];
    text = builtins.readFile ./mediaplayer.sh;
  };
}
