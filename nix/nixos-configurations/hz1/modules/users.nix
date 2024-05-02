{
  pkgs,
  config,
  ...
}: {
  security.sudo.wheelNeedsPassword = false;

  nix.settings.trusted-users = ["root" "@wheel"];

  programs.fish = {
    shellInit = ''
      set fish_greeting
    '';
  };

  users.groups.deploy = {};
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
        extraGroups = [
          "adbusers"
          "wheel"
          "networkmanager"
          "audio"
          "video"
          "docker"
          "lp"
          "scanner"
          "vboxusers"
          "kvm"
        ];
      };

      deploy = {
        openssh.authorizedKeys = {
          keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYtnGgX7k8iCFE8RexF7AHaCvpDl2he2I44tWeVAd4jsev3fyyehtlR1Y8ABE87AHddwQ4EACSNkpHqD4UTVEgmoPLkSjO4BwQ5K7ubAQLtJyBDqyGttoyN0TPkv/xWgyb/EdOBisPGeNCfKn2h3PA/nYz11OZp3RFkjxx23k7krclgsgB6Eg23uYIxrKp7p9FXxlP0kQNy8xPqKPjaOudTCv+jH9zyfErUXqvpgSBlH0nO4Tao6tbXqNPMFPBkc8d+73GR/lkJiuvc8n8K+SpU97Fbm0dFnCbbElwxY6lN/Rb0NTGQoZobOWErZL8V46EEM9AjTcWNYmTfJ9MhJbVng7DRubmik0hW2ht5qDOAygvb5kl9ERm2e2AuD6gGQJgOcIE6C3oWMxKEAwUw5w4+XunKcOh/RrLbAXRBI/oFcPMv+xU/lAut10GzAC3MQElhwuF6HeEoXhI5Gxj0e0OYU/g+lHUrapHU2Ax6RkRxkT6PhZ5DFS1C6aimRXSQ3s= anton@thinkpad-x1"
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDX5YDHxGFVhJGfYypDTEUfVi8ZvzwGw5RqtqRQ6Xxrr5/gyYVKK3T5i+rTqlmnCITdfXrQzZOW60bVDYrUDVf5uP5CoKHzFu9G56sTCn4P+bi3zmKSqan9FVKVl6kRF2dpQ5zl6YNJLBssMD6Q+qU/Igp2jHDmq7uICiRmguEMKSVXd6WnExdnBlhpPR2t46RtyvfHlAaegh/rH/RTV14gIcEcXZBtt7qzgGWUeNnAukiiB0UCjUw0TqjmhHHsMqdQx59pOZ67n3pihnYYbxLcXXxThmIbMlTLrADxPjyQCw0BCMDQbWetafJWMclQyjnvpPmAdNGl7Z6eXYki48rOfiOJDNY3riU3RH0NRjnxKkjUQngWs4ZC884K3yOLH1zSACmpJTXtF189/tVYwhrHcitI7yIkEZ8aRLpBYoufgauymaBCh9GHHo2ojh8Qxj9GOvll9UPr3keRfbxOq2+ic2SQv7/y36a1o2rUKyi3J57nh5G//6BpfPmtW0mcDRE= drone-runner-exec@nixos"
          ];
        };
        isNormalUser = true;
        shell = pkgs.bash;
        group = "deploy";
        extraGroups = ["wheel"];
      };
    };
  };
}
