_: {
  home = {
    file.".npmrc".text = ''
      prefix = ~/.npm-packages
    '';

    sessionVariables = {NODE_PATH = "~/.npm-packages/lib/node_modules";};
    sessionPath = ["~/.npm-packages/bin"];
  };
}
