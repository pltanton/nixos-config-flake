{ pkgs, config, ... }: {
  users.groups.deploy = { };
  users = {
    users = {
      anton = {
        openssh.authorizedKeys = {
          keys = [
            "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBPTAlFRwD3rXUYqCUBSZFpBLJYP9dXSV4gWxSP/dAdPjuYQHZxghMigubprVhoHLrUD/4w7BgB8QR356qGHeNTUAAAAEc3NoOg== anton@nixos"
          ];
        };

        isNormalUser = true;
        shell = pkgs.fish;
        home = "/home/anton";
        extraGroups = [ "wheel" "docker" ];
      };
    };
  };
}
