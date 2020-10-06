{ pkgs, ... }: {
  # services.udev = {
  #   packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];
  # };

  # environment.shellInit = ''
  #   export GPG_TTY="$(tty)"
  #   gpg-connect-agent /bye
  #   export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  # '';

  # programs = {
  #   ssh.startAgent = false;
  #   gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true;
  #   };
  # };
}
