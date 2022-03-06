{ pkgs, ... }: {
  console = {
    keyMap = "dvorak";
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };
  i18n.defaultLocale = "en_US.UTF-8";
}
