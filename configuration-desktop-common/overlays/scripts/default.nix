self: super: rec {
  wofi-emoji = super.callPackage ./wofi-emoji { };
  brightness = super.writeShellApplication {
    name = "brightness";
    runtimeInputs = with super.pkgs; [ light ddcutil ];
    text = builtins.readFile ./brightness.sh;
  };
  screenshot = super.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with super.pkgs; [ satty grim slurp libnotify ];
    text = builtins.readFile ./screenshot.sh;
  };
}
