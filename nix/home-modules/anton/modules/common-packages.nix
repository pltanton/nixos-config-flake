{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    nixd # A language server for Nix.
    alejandra # A Nix code formatter.

    gopls

    ####################
    # Development      #
    ####################
    # CLI Tools
    gitAndTools.gh # GitHub CLI for interacting with GitHub from the command line.
    glab # A GitLab CLI tool.
    bat # A `cat` replacement with syntax highlighting.
    btop # A modern resource monitor for processes and system usage.
    curlie # A user-friendly alternative to `httpie` for HTTP requests.
    dig # A DNS lookup utility.
    duf # A more user-friendly alternative to `df` for disk usage.
    htop # An interactive process viewer.
    inetutils # A collection of common network utilities.
    jq # A command-line JSON processor.
    procs # A modern replacement for `ps` with additional features.
    ripgrep # A fast and efficient search tool for files.
    yazi # A terminal file manager.
    tmux # A terminal multiplexer for managing multiple terminal sessions.
    unzip # A utility for extracting ZIP archives.
    wget # A command-line tool for downloading files from the web.
    tree # A command-line tool to display directory structures.
    tldr

    kubectl # K8S
    kubectx

    # Programming Languages & Tools

    nixos-rebuild
    coreutils # GNU core utilities for basic file and text operations.
    grpc # A high-performance RPC framework.
    grpcurl # A command-line tool for interacting with gRPC servers.
    sops # A tool for managing encrypted secrets.
    protobuf # A protocol buffers library for serializing structured data.
    protoc-gen-go # A Go plugin for generating protobuf code.
    protoc-gen-go-grpc # A Go plugin for generating gRPC code.
    zip # A compression and file packaging utility.
    neovim # Highly customizable text editor.
    uv
  ];
}
