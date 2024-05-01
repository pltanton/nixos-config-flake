{ pkgs, config, ... }: {
  nix.settings.trusted-users = [ "root" "@wheel" ];

  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting

      function nshell
        nix shell --impure n#$argv
      end
    '';
  };

  users = { defaultUserShell = pkgs.fish; };
}
