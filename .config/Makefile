
zsh_config_files := .zshrc .zshenv
tmux_config_files := .tmux.conf

1stsetup4mac: setup brew_setup mac_cli_install mac_gui_dev_install mac_gui_install

setup: deploy zsh_plugin
	@echo "Setup done!!"
setup4WSL: deploy4WSL zsh_plugin
	@echo "Setup done!!"
deploy: ## Create Symlink to HOME directory 
	@echo "Start to deploy dotfiles to HOME !!!"
	-@mkdir $(HOME)/.config
	@##making symbolic link for config file
	@$(foreach x,$(zsh_config_files),ln -s $(HOME)/dotfiles/.config/zsh/$(x) $(HOME)/$(x);)  
	@$(foreach x,$(tmux_config_files),ln -s $(HOME)/dotfiles/.config/tmux/$(x) $(HOME)/$(x);)
	@##making symbolic link for neovim config files
	@ln -s $(HOME)/dotfiles/.config/nvim/ $(HOME)/.config
	-@mkdir $(HOME)/.config/zinit
	@ln -s $(HOME)/dotfiles/.config/zsh/zinit/ $(HOME)/.config/zinit/
	@ln -s $(HOME)/dotfiles/.config/alacritty.yml $(HOME)/.config/alacritty.yml

deploy4WSL: ## Create Symlink to HOME directory 
	@echo "Start to deploy dotfiles to HOME !!!"
	-@mkdir $(HOME)/.config
	@##making symbolic link for config file
	@$(foreach x,$(zsh_config_files),ln -s $(HOME)/dotfiles/.config/zsh/$(x) $(HOME)/$(x);)  
	@$(foreach x,$(tmux_config_files),ln -s $(HOME)/dotfiles/.config/tmux/.tmuxforWSL.conf $(HOME)/$(x);)
	@##making symbolic link for neovim config files
	@ln -s $(HOME)/dotfiles/.config/nvim/ $(HOME)/.config
	-@mkdir $(HOME)/.config/zsh
	-@mkdir $(HOME)/.config/zsh/plugin
	@ln -s $(HOME)/dotfiles/.config/zsh/plugin/zinit/ $(HOME)/.config/zsh/plugin/zinit

zsh_plugin:
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
brew_setup:
	-@mkdir /usr/local
	@echo "Start installation of Homebrew"
	-@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	@echo"Done!!"
	@brew update
	@echo "Update Done!"
mac_git: 
	@brew install git
mac_python:
	@brew install python3
mac_zsh:
	@brew install zsh
	@chsh -s /usr/local/bin/zsh
	@echo "Default zsh is zsh from brew!"
mac_haskell:
	@brew install haskell-stack hlint
mac_neovim:
	@brew install neovim
mac_tmux:
	@brew install tmux
mac_powerline:
	@pip3 install --user powerline-status
mac_cli_install: mac_git mac_python mac_zsh mac_haskell  mac_neovim mac_tmux mac_powerline 
	@brew install reattach-to-user-namespace exa fd
mac_Alacritty:
	@brew cask install alacritty
mac_firefox:
	@brew cask install firefox
mac_intellij:
	@brew cask install intellij-idea
mac_google-backup-and-sync:
	@brew cask install google-backup-and-sync
mac_processing:
	@brew cask install processing
mac_dropbox:
	@brew cask install dropbox
mac_gui_dev_install: mac_Alacritty mac_firefox mac_intellij mac_google-backup-and-sync mac_processing mac_dropbox

mac_discord:
	@brew cask install discord
mac_keepassxc:
	@brew cask install keepassxc
mac_spotify:
	@brew cask install spotify
mac_vlc:
	@brew cask install vlc
mac_googleJide:
	@brew cask install google-japanese-ime
mac_font-cica:
	@brew cask install font-cica

mac_gui_install: mac_discord  mac_keepassxc mac_spotify  mac_vlc mac_googleJide mac_font-cica
