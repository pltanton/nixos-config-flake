_: {
  services = {
    openssh = {
      settings.PermitRootLogin = "prohibit-password";
      enable = true;
    };
  };
}
