{pkgs, ...}: {
  console = {
    # keyMap = "dvorak";
    useXkbConfig = true;
    font = "ter-i32b";
    packages = with pkgs; [terminus_font];
    earlySetup = true;
  };
}
