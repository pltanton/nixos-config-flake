{pkgs, ...}: {
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
