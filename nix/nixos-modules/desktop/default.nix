{inputs, ...}: {
  imports = with inputs;
    [
      self.nixosModules.common
      self.nixosModules.sops

      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
    ]
    ++ self.lib.modulesDir ./.;

  sops = {
    scope = "desktop";
    age.keyFile = "/home/anton/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/home/anton/.ssh/id_ed25519"];
  };

  time.timeZone = "Asia/Nicosia";

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;

    permittedInsecurePackages = [];
  };
}
