{
  lib,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  makeBinaryWrapper,
  ripgrep,
  versionCheckHook,
  installShellCompletions ? stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "codex";
  version = "0.116.0";

  src = fetchurl {
    url = "https://github.com/openai/codex/releases/download/rust-v${finalAttrs.version}/codex-aarch64-apple-darwin.tar.gz";
    hash = "sha256-FIc19fIgmy9qMb18o2icYowubFJo/7oL6T93IPz4kvU=";
  };

  # The release asset is a tar.gz containing a single binary at the top level.
  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  installPhase = ''
    mkdir -p "$out/bin"
    tar -xzf "$src" -C "$out/bin"
    mv "$out/bin/codex-aarch64-apple-darwin" "$out/bin/codex"
    chmod +x "$out/bin/codex"
  '';

  postInstall = lib.optionalString installShellCompletions ''
    installShellCompletion --cmd codex \
      --bash <($out/bin/codex completion bash) \
      --fish <($out/bin/codex completion fish) \
      --zsh <($out/bin/codex completion zsh)
  '';

  postFixup = ''
    wrapProgram $out/bin/codex --prefix PATH : ${lib.makeBinPath [ ripgrep ]}
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];

  meta = {
    description = "Lightweight coding agent that runs in your terminal";
    homepage = "https://github.com/openai/codex";
    changelog = "https://raw.githubusercontent.com/openai/codex/refs/tags/rust-v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    mainProgram = "codex";
    platforms = [ "aarch64-darwin" ];
  };
})
