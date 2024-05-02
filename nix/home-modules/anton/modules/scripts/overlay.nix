self: super: rec {
  wofi-emoji = super.callPackage ./wofi-emoji {};
  screenshot = super.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with super.pkgs; [unstable.satty grim slurp libnotify];
    text = builtins.readFile ./screenshot.sh;
  };
}
