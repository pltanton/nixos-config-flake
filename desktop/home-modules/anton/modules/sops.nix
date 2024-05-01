{ pkgs, ... }: {
  sops = {
    age.sshKeyPaths = [ "/home/anton/.ssh/id_ed25519" ];
    defaultSopsFile = ../secrets.yaml;
  };
 
  home.packages = [
    pkgs.age
    pkgs.sops
  ];
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
  };

  # https://github.com/mozilla/sops#47showing-diffs-in-cleartext-in-git
  programs.git.extraConfig = {
    diff.sopsdiffer = {
      textconv = "${pkgs.sops}/bin/sops --config /dev/null -d";
    };
  };
}
