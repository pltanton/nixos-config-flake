{ pkgs, ... }: {
  home.packages = with pkgs; [
    # black # Python code formatter
    # conda
    python3
    # (python3.withPackages (pp:
    #   with pp; [
    #     pip
    #     pylint
    #     pyright
    #     jedi
    #     flake8
    #     autopep8
    #     pygments
    #     hvac
    #     pika
    #     grpcio-tools
    #     mypy
    #     sqlalchemy
    #   ]))
    # poetry
  ];
}
