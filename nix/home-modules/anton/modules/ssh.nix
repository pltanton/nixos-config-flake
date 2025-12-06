{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    matchBlocks = {
      "*".addKeysToAgent = "yes";

      "*.kaliwe.ru *.pltanton.dev 192.* 10.* *.github.com" = {
        identityFile = "~/.ssh/id_ed25519_sk_rk_home";
      };
    };
    # defaultValues = false;
  };
}
