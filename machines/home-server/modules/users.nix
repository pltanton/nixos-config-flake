{ pkgs, ... }: {
  users.users.anton = {
    extraGroups = [ "publicstore" "privatestore" ];
  };
}
