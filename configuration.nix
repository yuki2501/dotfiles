{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim git
  ];

  nix.package = pkgs.nix;

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.primaryUser = "yuki";

  system.stateVersion = 6;
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    CreateDesktop = false;
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  system.defaults.dock = {
    autohide = true;
    show-recents = false;
    tilesize = 30;
    magnification = false;
    largesize = 40;
    orientation = "right";
    mineffect = "scale";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    brews = [
      "deno"
    ];
    casks = [
      "lulu"
      "reikey"
      "xld"
      "nikitabobko/tap/aerospace"
      "tla+-toolbox"
      "blackhole-2ch"
    ];
  };
}

