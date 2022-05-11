{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [ fasd fzf grc ];

  home.sessionPath = [ "/home/anton/go/bin" ];

  programs.fish = {
    enable = true;

    shellInit = ''
      go env -w GOPROXY=https://athens.s.o3.ru,https://proxy.golang.org,direct
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "fasd";
        src = inputs.fish-z-plugin;
      }
      {
        name = "colored-man";
        src = inputs.fish-colored-man-plugin;
      }
      {
        name = "grc";
        src = inputs.fish-grc;
      }
      (with fzf-fish; { inherit name src; })
      (with done; { inherit name src; })
      (with pure; { inherit name src; })
      (with pisces; { inherit name src; })
    ];
  };
}
