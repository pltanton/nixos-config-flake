{ config, pkgs, ... }:

let

  availablePackages = with pkgs; [
    nixUnstable
    git
    curl
    httpie
    openssh
    gnutar
    bash
    gzip
  ];
in {
  systemd.services.drone-runner-exec = {

    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = [ "/home/deploy/drone-exec-runner-secrets.env" ];
      Environment = [
        "DRONE_RPC_PROTO=http"
        "DRONE_RUNNER_CAPACITY=10"
        "CLIENT_DRONE_RPC_HOST=127.0.0.1:3030"
        "NIX_REMOTE=daemon"
        "PAGER=cat"
      ];
      ExecStart = "${pkgs.drone-runner-exec}/bin/drone-runner-exec";
      User = "deploy";
      Group = "deploy";
      BindPaths = [
        "/nix/var/nix/daemon-socket/socket"
        "/home/deploy/.ssh"
        "/home/deploy/go"
        "/home/deploy/.config/git"
      ];
      BindReadOnlyPaths = [
        "/usr/bin/env"
        "/bin/sh"
        "/etc/passwd"
        "/etc/group"
        "/etc/resolv.conf"
        "/nix/var/nix/profiles/system/etc/nix:/etc/nix"
        "${
          config.environment.etc."ssl/certs/ca-certificates.crt".source
        }:/etc/ssl/certs/ca-certificates.crt"
        "${
          config.environment.etc."ssh/ssh_known_hosts".source
        }:/etc/ssh/ssh_known_hosts"
        "/etc/machine-id"
        "/nix/"
      ];
    };

    path = availablePackages;

    confinement = {
      enable = true;
      packages = availablePackages;
    };
  };
}
