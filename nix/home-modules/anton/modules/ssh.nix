{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.openssh;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      "*.kaliwe.ru *.pltanton.dev 192.* 10.* *.github.com" = {
        identityFile = "~/.ssh/id_ed25519_sk_rk_retro";
      };
    };
    # defaultValues = false;
  };
}
