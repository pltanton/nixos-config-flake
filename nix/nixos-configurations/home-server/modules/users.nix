_: {
  nix.settings.trusted-users = ["root" "@wheel"];

  programs.fish = {
    shellInit = ''
      set fish_greeting
    '';
  };
}
