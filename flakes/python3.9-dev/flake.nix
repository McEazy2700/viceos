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
            pkgs.fish
          ];
          shellHook = ''
            export PYTHONPATH="${python}/bin/python"
            echo "Python 3.9 environment with Poetry activated"

            # Create a helper function to activate poetry in fish
            mkdir -p ~/.config/fish/functions/
            cat > ~/.config/fish/functions/pshell.fish << 'EOL'
            function pshell --description 'Activate Poetry virtualenv with fish'
              set -l venv (poetry env info --path)
              if test -n "$venv"
                source $venv/bin/activate.fish
              else
                echo "No active Poetry virtualenv found"
                return 1
              end
            end
            EOL

            # Start fish shell
            exec fish
          '';
        };
      }
    );
}
