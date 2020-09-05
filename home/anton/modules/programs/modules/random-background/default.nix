{ pkgs, ... }: {
  services.random-background = {
    enable = true;
    imageDirectory = "%h/.config/nixpkgs/backgrounds";
  };
}
