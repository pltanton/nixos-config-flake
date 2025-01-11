{...}: {
  home.file.".npmrc".text = ''
    prefix = ~/.npm-packages
  '';

  home.sessionVariables = {NODE_PATH = "~/.npm-packages/lib/node_modules";};
  home.sessionPath = ["~/.npm-packages/bin"];
}
