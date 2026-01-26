_: {
  services = {
    openssh = {
      enable = true;
      settings = {PermitRootLogin = "prohibit-password";};
      knownHosts = {
        yubikeyRetro = {
          publicKey = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHLXuBAw1QXZwmTGRP28QSrlY+56nZzXvKm79TITlnaUAAAACXNzaDpyZXRybw== ssh:retro";
        };
        nitrokey = {
          publicKey = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIImB/mXR3Ivn7tAT+jdsqtR8BjLgLvoMZUvfYuN/+05AAAAADHNzaDpuaXRyb2tleQ== ssh:nitrokey";
        };
      };
    };
  };
}
