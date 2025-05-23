{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "screenshot";
      runtimeInputs = with pkgs; [unstable.satty grim slurp libnotify];
      text = builtins.readFile ./screenshot.sh;
    })

    (pkgs.writeShellApplication {
      name = "xkb-smart-switch";
      runtimeInputs = with pkgs; [hyprland jq];
      text = builtins.readFile ./xkb-smart-switch.sh;
    })
  ];
}
