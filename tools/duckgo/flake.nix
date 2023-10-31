{
  description = "duckgo is a command line tool to query DuckDuckGo and open items from search result with Web browser quickly.";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem  (system:
      let
        pkgs = import nixpkgs.path {inherit system;};

        duckgo = pkgs.stdenv.mkDerivation rec {
          pname = "duckgo";
          version = "v0.1.0-alpha"; # ツールのバージョンを指定

          src = pkgs.fetchurl {
            url = "https://github.com/sheepla/duckgo/releases/download/${version}/duckgo_Darwin_x86_64.tar.gz"; # 適切なURLに置き換える
            sha256 = "sha256-d5yn5dtVpaIJ1dDkpnoZMcmAYyAAbTbK/s6ldReFRhI="; 
            # 適切なハッシュに置き換える
          };

          phases = [ "installPhase" ];

          installPhase = ''
           mkdir -p $out/bin
           tar -xf $src -C $out/bin
          '';

          meta = with pkgs.lib; {
            description = "Your CLI tool description";
            license = licenses.mit; # ライセンスを適切に指定
          };
        };
      in {
        packages.duckgo = duckgo;
        defaultPackage = duckgo;
      });
}
