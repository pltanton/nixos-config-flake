{inputs, ...}: {
  imports = with inputs;
    [
      self.nixosModules.common
      self.nixosModules.sops

      home-manager.nixosModules.home-manager
      dms.nixosModules.greeter
    ]
    ++ self.lib.modulesDir ./.;

  sops = {
    scope = "desktop";
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };

  # time.timeZone = "Asia/Dubai";
  time.timeZone = "Asia/Nicosia";
  # time.timeZone = "Europe/Belgrade";

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;

    permittedInsecurePackages = [];
  };
}
