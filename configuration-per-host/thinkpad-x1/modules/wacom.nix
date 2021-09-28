{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.xf86_input_wacom ];
  services.udev.packages = [ pkgs.xf86_input_wacom ];
}
