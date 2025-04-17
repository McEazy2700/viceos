{
  description = "Python 3.9 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; # A version with Python 3.9
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
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.python39
            # Add any other dependencies here
          ];
        };
      }
    );
}
