{pkgs, ...}: {
  programs.vscode = {
    enable = false;
    package = pkgs.vscodium;
    profiles.default.extensions.packages = with pkgs.vscode-extensions; [
      golang.go # Go language support
      vscodevim.vim # Vim keybindings for VSCode
      bbenoist.nix # Nix language support
      alefragnani.project-manager # Project management tool
      vspacecode.vspacecode # Visual Studio Code improvements
      vspacecode.whichkey # An extension for vim keybindings

      esbenp.prettier-vscode # Prettier code formatter for VSCode
      yzhang.markdown-all-in-one # Markdown editing features for VSCode

      continue.continue # Continue feature for debugging in VSCode
    ];
  };
}
