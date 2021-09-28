{ pkgs, ... }: {
  services = {
    openssh = {
      enable = true;
      knownHosts = {
        soloKeyPersonalLaptop = {
          publicKey =
            "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBPTAlFRwD3rXUYqCUBSZFpBLJYP9dXSV4gWxSP/dAdPjuYQHZxghMigubprVhoHLrUD/4w7BgB8QR356qGHeNTUAAAAEc3NoOg==";
        };
      };
    };
  };
}
