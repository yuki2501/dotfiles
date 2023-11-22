{
  description = "my project";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          nix = [ pkgs.rnix-lsp ];
        in
        rec
        {
          devShell = pkgs.mkShell {
            buildInputs = pkgs.lib.lists.flatten [ nix ];
          };
        });
}

