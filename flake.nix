{
  description = "Vice's NixOs";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    dfx-nix.url = "github:nomeata/dfx-in-nix"; # New line
  };
  outputs = { self, nixpkgs, stylix, home-manager, dfx-nix, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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
            {
              nixpkgs.overlays = [ dfx-nix.overlays.default ]; # Add this line
            }
            stylix.homeManagerModules.stylix
            ./home.nix
            { nixpkgs.config.allowUnfree = true; }
          ];
        };
      };
    };
}
