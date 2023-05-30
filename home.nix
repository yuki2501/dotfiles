{ pkgs, ... }:

{
  home.username = "yuki";
  home.homeDirectory = "/Users/yuki";
  home.stateVersion = "22.05";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.git = {
    enable = true;

    userName = "yuki25011";
    userEmail = "yuki2501@pm.me";
  };

  programs.home-manager = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    completionInit = "autoload -U compinit && compinit -u";
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
    envExtra = ''
     export NIX_PATH=$HOME/.nix-defexpr/channels
     if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
       . ~/.nix-profile/etc/profile.d/nix.sh
     fi
    '';
    enableAutosuggestions = {
      enable = true;
    };
    shellAliases = {
      cp = "cp -i";
      rm = "rm -i";
      mv = "mv -i";
      exa = "exa --all";
      wet = "curl wttr.in/Sendai"; 
    };
    history = {
      extended = true;
      path = "$(config.xdg.dataHome}/zsh/.zsh_history";
      save = 1000000;
      size = 1000000;
    };
  };
  programs.alacritty = {
    enable = true;
    settings = ''
      font:
          bold:
              family: PlemolJP35 Console NF
              style: Bold
          bold_italic:
              family: PlemolJP35 Console NF
              style: Bold Italic
          italic:
              family: PlemolJP35 Console NF
              style:  Italic
          normal:
              family: PlemolJP35 Console NF
              style: Text
          size: 17.5

      window:
        opacity: 0.998 
        decorations: buttonless

      shell:
          program: /usr/local/bin/zsh

      key_bindings:
        - { key: Yen,        chars: "\x5C"                      }
        - { key: Yen, mods: Alt,       chars: "\xA5"                      }

      colors:
        # Default colors
        primary:
         background: '0x232136'
         foreground: '0xe0def4'
         cursor:
          text: '#2e3440'
          cursor: '#d8dee9'
        vi_mode_cursor:
          text: '#2e3440'
          cursor: '#d8dee9'
        selection:
          text: CellForeground
          background: '#4c566a'
        search:
          matches:
            foreground: CellBackground
            background: '#88c0d0'
          # bar:
          #   background: '#434c5e'
          #   foreground: '#d8dee9'
        # Normal colors
        normal:
          black:   '0x393552'
          red:     '0xeb6f92'
          green:   '0xa3be8c'
          yellow:  '0xf6c177'
          blue:    '0x569fba'
          magenta: '0xc4a7e7'
          cyan:    '0x9ccfd8'
          white:   '0xe0def4'
        # Bright colors
        bright:
          black:   '0x47407d'
          red:     '0xf083a2'
          green:   '0xb1d196'
          yellow:  '0xf9cb8c'
          blue:    '0x65b1cd'
          magenta: '0xccb1ed'
          cyan:    '0xa6dae3'
          white:   '0xe2e0f7'
        indexed_colors:
          - { index: 16, color: '0xea9a97' }
          - { index: 17, color: '0xeb98c3' }
    '';
  };

}
