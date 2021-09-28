{ config, pkgs, ... }:

{
  services.mtprotoproxy = {
    enable = true;
    port = 1194;
    users = {
      "tg" = "5294fff8a95e98445de3bc8e558fd3ef";
    };
  };
}
