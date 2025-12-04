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
    [signing]
      key = null
  '';
  # sshCommand = "ssh -I ${libykcs11}"

  programs.git = {
    enable = true;

    settings = {
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

      user = {
        name = "Anton Plotnikov";
        email = "plotnikovanton@gmail.com";
      };
    };

    includes = [
      {
        path = "~/.config/git/config.wallet";
        condition = "hasconfig:remote.*.url:git@gitlab.walletteam.org*/**";
      }
    ];

    signing = {
      key = "3CD1E7C05DE129DF2E8608DD666F4A84A390B618";
      # key = "0DC2C394B4A6E61B4F1ADAB5CB3A51C0BB088893";
      signByDefault = true;
    };
  };

  home.packages = with pkgs; [git-crypt];
}
