{
  description = "Python 3.9 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python39;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            python
            pkgs.poetry
          ];
          shellHook = ''
            export PYTHONPATH="${python}/bin/python"
            echo "Python 3.9 environment with Poetry activated"
          '';
        };
      }
    );
}
