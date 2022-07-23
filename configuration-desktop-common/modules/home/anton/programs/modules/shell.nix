{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [ fasd fzf grc ];

  home.sessionPath = [ "/home/anton/go/bin" ];

  home.sessionVariables = {
    # Wayland enable
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    # MOZ_ENABLE_WAYLAND = 1;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    GDK_BACKEND = "wayland";

    KUBECONFIG = "/home/anton/.kube/config";
  };

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
