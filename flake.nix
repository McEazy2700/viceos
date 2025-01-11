{
  description = "Vice's NixOs";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    gio-src.url = "sourcehut:~eliasnaur/gio";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    nvf.url = "github:notashelf/nvf";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nixpkgs
    , stylix
    , nixvim
    , home-manager
    , rust-overlay
    , nvf
    , ...
    }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        vice = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            stylix.homeManagerModules.stylix
            { nixpkgs.config.allowUnfree = true; }
            ./home.nix
            nixvim.homeManagerModules.nixvim
          ];
        };
      };
      devShells.${system} = {
        gio = pkgs.mkShell {
          buildInputs = with pkgs; [
            openssl
            openssl.dev
            sqlite
            gdbm
            readline
            libffi
          ];
        };
      };
    };
}
