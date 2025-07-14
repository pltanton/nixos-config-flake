{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    addKeysToAgent = "yes";
    # matchBlocks."*.kaliwe.ru *.pltanton.dev 192.* 10.*" = {
    #   identityFile = "~/.ssh/id_ed25519_sk_nitrokey";
    # };
  };
}
