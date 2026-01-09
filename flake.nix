{
  description = "Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = { self, nixpkgs, nix-darwin, home-manager, neovim-nightly-overlay}:
    let
      darwinUser = builtins.getEnv "DARWIN_USER";
      darwinHost = builtins.getEnv "DARWIN_HOST";
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      mkDarwinSystem = { hostname, username }: nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit (nixpkgs) lib;
        };
      };
    in {
      darwinConfigurations.${darwinHost} = mkDarwinSystem {
        hostname = darwinHost;
        username = darwinUser;
      };
      homeConfigurations = {
        myHomeConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit  neovim-nightly-overlay;
          };
          modules = [./home.nix];
        };
      };
    };
}

