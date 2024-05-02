{
  pkgs,
  config,
  ...
}: {
  services.swayosd = {
    enable = true;
  };
}
