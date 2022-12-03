pcall(require, "impatient")
pcall(require, "filetype")
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1
vim.g.did_indent_on             = 1
vim.g.did_load_filetypes        = 1
vim.g.did_load_ftplugin         = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_man                = 1
vim.g.loaded_matchit            = 1
vim.g.loaded_matchparen         = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_remote_plugins     = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.loaded_zipPlugin          = 1
vim.g.skip_loading_mswin        = 1
vim.g.did_install_default_menus = 1
vim.g.did_indent_on             = 1
vim.g.did_load_ftplugin         = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_man                = 1
vim.g.loaded_matchit            = 1
vim.g.loaded_matchparen         = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_remote_plugins     = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.loaded_zipPlugin          = 1
vim.g.skip_loading_mswin        = 1
-- Neovim provider """
-- Doc: https://neovim.io/doc/user/provider.html
-- Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
vim.cmd[[let g:xdg_config_home = !empty($XDG_CONFIG_HOME)
    \ ? $XDG_CONFIG_HOME
    \ : $HOME . '/.config'
let g:xdg_cache_home  = !empty($XDG_CACHE_HOME)
    \ ? $XDG_CACHE_HOME
    \ : $HOME . '/.cache'
let g:xdg_data_home   = !empty($XDG_DATA_HOME)
    \ ? $XDG_DATA_HOME
    \ : $HOME . '/.local/share'
]]
-- Indent
vim.opt.tabstop=2
vim.opt.shiftwidth=2 
vim.opt.softtabstop=2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
-- Split
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse= 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorcolumn = true
vim.opt.cursorline  = true
vim.opt.pumblend=10
vim.opt.winblend=15
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'
pcall(require,"plugin.dein.dein")
vim.cmd[[" Look and Feel
" All previous modes
" Automatically wrap left and right
set colorcolumn=80
set shell=/usr/local/bin/zsh
set cmdheight=0
"set clipboard = unnamedplus
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
let mapleader = ","
noremap \ , 
inoremap <silent> jj <ESC>
set shada='20,<50,s10
set updatetime=1
]]

