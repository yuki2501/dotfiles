# making directory for homebreww
mkdir /usr/local
mkdir /$HOME/.config
config_files=(zsh/.zshrc zsh/.zshenv tmux/.tmux.conf )
#making symbolic link for config file
for files in $config_files; do
    ln -s $HOME/dotfiles/.config/$files /$HOME/$files
done
#making symbolic link for neovim config files
ln -s $HOME/dotfiles/.config/nvim/ $HOME/.config

echo "Let's install Homebrew!!!"

#install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo ""
