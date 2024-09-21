{ pkgs, ... }:
{
  # システムにインストールするパッケージ
  environment.systemPackages = with pkgs; [
    vim
    git
   
  ];

  # Nixデーモンの自動アップグレードを有効化
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # zshの設定
  programs.zsh.enable = true;

  # 非自由パッケージを許可
  nixpkgs.config.allowUnfree = true;

  # Finder設定
  system.defaults.finder = {
    # 全てのファイル拡張子を表示: trueにすると、すべてのファイルの拡張子が表示されます。
    # ファイルタイプを一目で確認できるため、ファイル管理が容易になります。
    AppleShowAllExtensions = true;

    # 隠しファイルを表示: trueにすると、通常は非表示のファイル（.で始まるファイル）も表示されます。
    # 開発作業や詳細な設定を行う際に便利ですが、通常使用では不要なファイルも表示されるため注意が必要です。
    AppleShowAllFiles = true;

    # デスクトップアイコンの非表示: falseにすると、デスクトップ上のアイコンが非表示になります。
    # クリーンな作業環境を好む場合や、デスクトップの整理を強制する場合に有用です。
    CreateDesktop = false;

    # 拡張子変更時の警告を無効化: falseにすると、ファイル拡張子を変更する際の警告が表示されなくなります。
    # 頻繁にファイル拡張子を変更する作業を行う場合、作業効率が向上します。
    FXEnableExtensionChangeWarning = false;

    # パスバーを表示: trueにすると、Finderウィンドウの下部にファイルパスが表示されます。
    # 現在の位置を把握しやすくなり、ディレクトリ間の移動が容易になります。
    ShowPathbar = true;

    # ステータスバーを表示: trueにすると、Finderウィンドウの下部に選択したアイテムの情報が表示されます。
    # ファイル数や容量などの情報を素早く確認できるため、ファイル管理に役立ちます。
    ShowStatusBar = true;
  };

  # Dock設定
  system.defaults.dock = {
    # Dockの自動非表示: trueの場合、Dockを自動で隠します。
    # これを有効にすると画面を広く使えるため、作業スペースが拡大します。
    autohide = true;

    # 最近使用したアプリケーションの非表示: falseにすると、Dockに最近のアプリが表示されなくなります。
    # プライバシーを重視する場合や、Dockをシンプルに保ちたい場合に有用です。
    show-recents = false;

    # Dockアイコンのサイズ: ピクセル単位でアイコンサイズを設定します。
    # 50pxは中程度のサイズで、見やすさと省スペースのバランスが取れています。
    tilesize = 30;

    # Dockアイコンの拡大機能: trueにすると、マウスオーバー時にアイコンが拡大表示されます。
    # アイコンの識別が容易になり、特に多くのアプリがDockにある場合に便利です。
    magnification = false;

    # 拡大時のアイコンサイズ: マウスオーバー時のアイコンサイズをピクセル単位で設定します。
    # 64pxは適度な拡大サイズで、アイコンの詳細が見やすくなります。
    largesize = 40;

    # Dockの位置: "bottom"、"left"、"right"のいずれかを指定できます。
    # 画面下部に配置すると、一般的なmacOSの外観に近くなります。
    orientation = "left";

    # ウィンドウ最小化エフェクト: "scale"は縮小エフェクトを使用します。
    # このエフェクトは視覚的に分かりやすく、システムの応答が速く感じられます。
    mineffect = "scale";

    # アプリケーション起動時のアニメーションを無効化: falseにすると、起動アニメーションが表示されなくなります。
    # システムの応答が速く感じられ、特に低スペックのマシンで有用です。
    launchanim = false;
  };

  # 下位互換性のため（変更時はchangelogを確認）
  system.stateVersion = 4;

  # ターゲットプラットフォーム
  nixpkgs.hostPlatform = "x86_64-darwin";
  
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    brews = [
      "deno"
    ];
    casks = [
      "raycast"
      "karabiner-elements"
      "discord"
      "lulu"
      "reikey"
      "ransomwhere"
      "xld"
      "iina"
    ];
  };
}

