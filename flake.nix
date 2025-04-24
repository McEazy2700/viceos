{
  description = "Vice's NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    stylix.url = "github:danth/stylix/release-24.11";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    stylix,
    nixvim,
    home-manager,
    rust-overlay,
    neovim-nightly-overlay,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    overlays = [
      rust-overlay.overlays.default
      neovim-nightly-overlay.overlays.default
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./configuration.nix];
      };
    };

    homeConfigurations = {
      vice = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nvf.homeManagerModules.default
          stylix.homeManagerModules.stylix
          ./home.nix
          nixvim.homeManagerModules.nixvim

          {
            nixpkgs.config.allowUnfree = true;
          }

          {
            programs.vscode = {
              enable = false;
            };

            services.wpaperd.enable = false;
          }
        ];
      };
    };
  };
}
