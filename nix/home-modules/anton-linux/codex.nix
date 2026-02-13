{...}: {
  home.file.".codex/config.json".text = builtins.toJSON {
    mcpServers = {
      nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
    };
  };
}
