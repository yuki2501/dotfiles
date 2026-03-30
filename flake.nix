{
  description = "Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
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
      darwinUser = "yuki";
      darwinHost = "yukimacmini";
      system = "aarch64-darwin";
      overlays = [
        neovim-nightly-overlay.overlays.default
        self.overlays.default
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      mkDarwinSystem = { hostname, username }: nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit (nixpkgs) lib;
        };
      };
    in {
      overlays.default = import ./overlays/ai-tools.nix;
      darwinConfigurations.${darwinHost} = mkDarwinSystem {
        hostname = darwinHost;
        username = darwinUser;
      };
      packages.${system} = {
        codex = pkgs.codex;
        claude-code = pkgs.claude-code;
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
