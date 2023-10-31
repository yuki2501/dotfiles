{ config, pkgs, lib, ... }:
let
  duckgoFlakeFunction = import ./tools/duckgo/flake.nix; 
  duckgoFlake = duckgoFlakeFunction.outputs {
    self = {};
    nixpkgs = import <nixpkgs> { };
    flake-utils = {
      lib = {
        eachDefaultSystem = f: {
          x86_64-darwin = f "x86_64-darwin";
        };
      };
    };
  };
in
{
  home.username = "yuki";
  home.homeDirectory = "/Users/yuki";
  home.stateVersion = "22.05";
  home.packages = [
    pkgs.ripgrep
    pkgs.joshuto
    pkgs.glow
    duckgoFlake.x86_64-darwin.defaultPackage
  ];
  programs.home-manager = {
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

      key_bindings=[
        { key= "Yen";        chars= "\\x5C";                      }
        { key= "Yen"; mods= "Alt";       chars= "\\xA5";          }
      ];

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
        brith.red     = "0xf083a2";
        brith.green   = "0xb1d196";
        brith.yellow  = "0xf9cb8c";
        brith.blue    = "0x65b1cd";
        brith.magenta = "0xccb1ed";
        brith.cyan    = "0xa6dae3";
        brith.white   = "0xe2e0f7";

        indexed_colors=[
          { index= 16; color= "0xea9a97"; }
          { index= 17; color= "0xeb98c3"; }
  	];
      };
     };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };  
  };

  programs.fzf = {
    enable = true;
    defaultOptions = ["--reverse"];
  };

  programs.exa = {
    enable = true;
    extraOptions = [
      "--all"
    ];
  };

  programs.bat = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
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
    set -g status "on"
    set -g status-justify "left"
    set -g status-style "fg=#cdcbe0,bg=#191726"
    set -g status-left-length "100"
    set -g status-right-length "100"
    set -g status-left-style NONE
    set -g status-right-style NONE
    set -g status-left "#[fg=#191726,bg=#569fba,bold] #S #[fg=#569fba,bg=#191726,nobold,nounderscore,noitalics]"
    set -g status-right "#[fg=#191726,bg=#191726,nobold,nounderscore,noitalics]#[fg=#569fba,bg=#191726] #{prefix_highlight} #[fg=#cdcbe0,bg=#191726,nobold,nounderscore,noitalics]#[fg=#191726,bg=#cdcbe0] %Y-%m-%d  %I:%M %p #[fg=#569fba,bg=#cdcbe0,nobold,nounderscore,noitalics]#[fg=#191726,bg=#569fba,bold] #h "
    setw -g window-status-activity-style "underscore,fg=#6e6a86,bg=#191726"
    setw -g window-status-separator ""
    setw -g window-status-style "NONE,fg=#6e6a86,bg=#191726"
    setw -g window-status-format "#[fg=#191726,bg=#191726,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#191726,bg=#191726,nobold,nounderscore,noitalics]"
    setw -g window-status-current-format "#[fg=#191726,bg=#cdcbe0,nobold,nounderscore,noitalics]#[fg=#191726,bg=#cdcbe0,bold] #I  #W #F #[fg=#cdcbe0,bg=#191726,nobold,nounderscore,noitalics]"

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

  programs.yt-dlp = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    completionInit = "autoload -U";
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
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
    '';
    profileExtra = ''
       if [ "$(uname -m)" = "arm64" ]; then
         eval "$(/opt/homebrew/bin/brew shellenv)"
         export PATH="/opt/homebrew/bin:$PATH"
       else
         eval "$(/usr/local/bin/brew shellenv)"
       fi
    '';
    history = {
      extended = true;
      path = "${config.xdg.dataHome}/zsh/.zsh_history";
      save = 1000000;
      size = 1000000;
    };
    shellAliases = {
      grep = "grep --colour=auto";
      c = "clear";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
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
