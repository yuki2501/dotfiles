{ pkgs, lib, neovim-nightly-overlay, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
    bussproofs latexmk collection-latexextra collection-langjapanese collection-fontsrecommended ;
  });
  username = "yuki_saito";
in
{
  nixpkgs = {
    overlays = [
      neovim-nightly-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.ripgrep
    pkgs.joshuto
    pkgs.glow
    pkgs.eza
    pkgs.plemoljp-nf
    pkgs.neovim
    tex
  ];
  programs.home-manager = {
    enable = true;
  };

  programs.yt-dlp = {
    enable = true;
  }; 

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };


  programs.git = {
    enable = true;
    userName = "yuki25011";
    userEmail = "yuki2501@pm.me";
  };


  programs.alacritty = {
    enable = true;
    settings = {
      font = {
          bold = {
              family= "PlemolJP35 Console NF";
              style= "Bold";
          };
          bold_italic = {
              family= "PlemolJP35 Console NF";
              style= "Bold Italic";
          };
          italic = {
              family = "PlemolJP35 Console NF";
              style = "Italic";
          };
          normal = {
              family = "PlemolJP35 Console NF";
              style = "Text";
         };
         size= 17.5;
      };
      window.opacity= 0.998; 
      window.decorations= "buttonless";
      colors = {
        primary.background = "0x232136";
        primary.foreground = "0xe0def4";

        normal.black   = "0x393552";
        normal.red     = "0xeb6f92";
        normal.green   = "0xa3be8c";
        normal.yellow  = "0xf6c177";
        normal.blue    = "0x569fba";
        normal.magenta = "0xc4a7e7";
        normal.cyan    = "0x9ccfd8";
        normal.white   = "0xe0def4";
        
        bright.black  = "0x47407d";
        bright.red     = "0xf083a2";
        bright.green   = "0xb1d196";
        bright.yellow  = "0xf9cb8c";
        bright.blue    = "0x65b1cd";
        bright.magenta = "0xccb1ed";
        bright.cyan    = "0xa6dae3";
        bright.white   = "0xe2e0f7";

        indexed_colors=[
          { index= 16; color= "0xea9a97"; }
          { index= 17; color= "0xeb98c3"; }
  	];
      };
     };
  };


  programs.fzf = {
    enable = true;
    defaultOptions = ["--reverse"];
  };


  programs.bat = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    prefix =  "C-q";
    customPaneNavigationAndResize = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    # package = ;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    extraConfig = ''
    set -g focus-events on
    set -ga terminal-overrides ',xterm-256color:Tc,alacritty:RGB'
    bind -T prefix c new-window
    # window の作成, 移動
    bind -T prefix c new-window
    bind -n M-c new-window -c "#{pane_current_path}"
    bind -T prefix n next-window
    bind -T prefix p previous-window
    set -g status-justify absolute-centre
    set -g status-position top
    set -g status-interval 1
    # session の作成, 移動
    bind -T prefix C new-session
    bind -T prefix l switch-client -n
    bind -T prefix h switch-client -p

    # pane の分割
    bind -T prefix v split-window -h  -c "#{pane_current_path}"
    bind -T prefix s split-window -v  -c "#{pane_current_path}"
    bind -n M-v split-window -h -c "#{pane_current_path}"
    bind -n M-s split-window -v -c "#{pane_current_path}"

    ## Rename Window & Session
    bind -T prefix r command-prompt -p "(rename-session '#S')" "rename-session '%%'"

    #!/usr/bin/env bash
    # Nightfox colors for Tmux
    # Style: duskfox
    # Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/duskfox/nightfox_tmux.tmux
    set -g mode-style "fg=#191726,bg=#cdcbe0"
    set -g message-style "fg=#191726,bg=#cdcbe0"
    set -g message-command-style "fg=#191726,bg=#cdcbe0"
    set -g pane-border-style "fg=#cdcbe0"
    set -g pane-active-border-style "fg=#569fba"
    bind -T prefix a choose-tree
    bind -T prefix e choose-session
    bind -T prefix w choose-tree -w

    # 'V' で行選択
    bind -T copy-mode-vi v send -X begin-selection
    # 'y'でyank
    bind -T copy-mode-vi y send -X copy-selection-and-cancel
    # 'C-v' で矩形選択
    bind -T copy-mode-vi C-v send -X rectangle-toggle

    '';
    
  };


  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    initExtra = ''
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey "^O" edit-command-line
    '';
    envExtra = ''
       export NIX_PATH=$HOME/.nix-defexpr/channels

       if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
         . ~/.nix-profile/etc/profile.d/nix.sh
       fi
       export DARWIN_USER=$(whoami)
       export DARWIN_HOST=$(hostname -s)

    '';
    profileExtra = ''
       if [ "$(uname -m)" = "arm64" ]; then
         eval "$(/opt/homebrew/bin/brew shellenv)"
         export PATH="/opt/homebrew/bin:$PATH"
       else
         eval "$(/usr/local/bin/brew shellenv)"
       fi
       export EDITOR=nvim
    '';
    history = {
      extended = true;
      path = "/Users/${username}/.config/zsh/.zsh_history";
      save = 1000000;
      size = 1000000;
    };
    shellAliases = {
      grep = "grep --colour=auto";
      c = "clear";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      eza = "eza --all";
      f = "joshuto";
      hm = "home-manager";
    };
    plugins = [
      {
        name = "tms";
        src = pkgs.fetchFromGitHub {
            owner = "yuki-yano";
            repo = "tms";
            rev = "b0822df";
            hash = "sha256-QXxWcS2lAp6MYtZH2lduwWCFxEpRuixHLDCQgM9r1BA=";
          };
      }
      {
        name = "tmk";
        src = pkgs.fetchFromGitHub {
          owner = "yuki-yano";
          repo = "tmk";
          rev = "4739566";
          hash = "sha256-KRonOUAfsROqon/ThBMneGAZClZ4kpqe3rlnsZxfAX8=";
        };
      }
    ];
  };
}
