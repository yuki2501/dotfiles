final: prev: {
  claude-code = prev.callPackage ../pkgs/claude-code/package.nix { };
  codex = prev.callPackage ../pkgs/codex/package.nix { };
}
