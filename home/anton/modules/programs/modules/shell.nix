{ pkgs, ... }: {
  home.packages = with pkgs; [ fasd ];
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "async-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "acomagu";
          repo = "fish-async-prompt";
          rev = "7b3dc39c031ad460a438b145c389a5b9570c68a0";
          sha256 = "18nxl53nc0hwpilgp2izz89mjmklh1r2iaacz9lw5kg4xw2h75hc";
        };
      }
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
      {
        name = "pure-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "rafaelrinaldi";
          repo = "pure";
          rev = "d66aa7f0fec5555144d29faec34a4e7eff7af32b";
          sha256 = "0klcwlgsn6nr711syshrdqgjy8yd3m9kxakfzv94jvcnayl0h62w";
        };
      }
    ];
  };
}
