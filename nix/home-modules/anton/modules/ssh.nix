{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    matchBlocks."*".addKeysToAgent = "yes";
    # defaultValues = false;
    # matchBlocks."*.kaliwe.ru *.pltanton.dev 192.* 10.*" = {
    #   identityFile = "~/.ssh/id_ed25519_sk_nitrokey";
    # };
  };
}
