{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."git/config.wallet".text = ''
    [user]
      email = "aplotnikov@walletteam.org"
      name = "Anton Plotnikov"
      signingkey = "${config.home.homeDirectory}/.ssh/yubikey_wallet_pub.pem"
    [gpg]
      format = ssh
    [gpg.ssh]
      allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers"
    [commit]
      gpgsign = true
  '';
  # sshCommand = "ssh -I ${libykcs11}"

  programs.git = {
    enable = true;
    userName = "Anton Plotnikov";
    userEmail = "plotnikovanton@gmail.com";

    extraConfig = {
      push.autoSetupRemote = true;

      url = {"git@github.com:" = {insteadOf = ["https://github.com/"];};};

      url = {
        "ssh://git@gitlab.fix.ru/" = {insteadOf = "https://gitlab.fix.ru/";};
      };

      url = {
        "ssh://git@gitlab.walletteam.org/" = {
          insteadOf = "https://gitlab.walletteam.org/";
        };
      };

      includeIf."hasconfig:remote.*.url:git@gitlab.walletteam.org*/**" = {
        path = "~/.config/git/config.wallet";
      };
    };

    signing = {
      key = null;
      signByDefault = true;
    };
  };

  home.packages = with pkgs; [git-crypt];
}
