{ config, pkgs, ... }:

{
  home.username = "yuki";
  home.homeDirectory = "/Users/yuki";
  home.stateVersion = "22.05";
  home.packages = [
    pkgs.deno 
    pkgs.ripgrep
  ];

  programs.home-manager = {
    enable = true;
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
  };

  programs.exa = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    extraConfig = ''
      set runtimepath+=${./.config/nvim}
      source ${./.config/nvim/init.lua}
    '';
  };
  programs.zsh = {
    enable = true;
    completionInit = "autoload -U && compinit -u";
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
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
      cp = "cp -i";
      grep = "grep --colour=auto";
      mv = "mv -i";
      rm = "rm -i";
    };
  };
}
