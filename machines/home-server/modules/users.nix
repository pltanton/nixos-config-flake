{ pkgs, homeBaseDir, ... }: {
  users.users.anton = {
    extraGroups = [ "publicstore" "privatestore" ];
  };

  home-manager.users.anton = { pkgs, inputs, ... }@value: {
    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = homeBaseDir + "/anton/modules/programs/modules/emacs/doom.d";
    };
  };
}
