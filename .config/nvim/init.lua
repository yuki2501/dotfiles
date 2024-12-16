-- vim.g.did_install_default_menus = 1
-- vim.g.did_install_syntax_menu   = 1
-- vim.g.did_indent_on             = 1
-- vim.g.did_load_filetypes        = 1
-- vim.g.did_load_ftplugin         = 1
-- vim.g.loaded_2html_plugin       = 1
-- vim.g.loaded_gzip               = 1
-- vim.g.loaded_man                = 1
-- vim.g.loaded_matchit            = 1
-- vim.g.loaded_matchparen         = 1
-- vim.g.loaded_netrwPlugin        = 1
-- vim.g.loaded_remote_plugins     = 1
-- vim.g.loaded_shada_plugin       = 1
-- vim.g.loaded_spellfile_plugin   = 1
-- vim.g.loaded_tarPlugin          = 1
-- vim.g.loaded_tutor_mode_plugin  = 1
-- vim.g.loaded_zipPlugin          = 1
-- vim.g.skip_loading_mswin        = 1
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
set shell=/bin/zsh
set cmdheight=0

" 最下部のstatuslineを表示しない
set laststatus=0

" ファイル末尾以降の`~`の表示を削除
set fillchars+=eob:\\x20

" 縦区切り線をシンプルに
set fillchars+=vert:│

" 横区切り線をシンプルに
set statusline=─
set fillchars+=stl:─,stlnc:─

" 区切り線のハイライトを抑え気味に
highlight! link StatusLine Comment
highlight! link StatusLineNC Comment
if has('nvim')
  highlight! link WinSeparator Comment
else
  highlight! link VertSplit Comment
endif

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
set shada='20,<50,s10
let &grepprg='rg --vimgrep'
set updatetime=1
let g:python3_host_prog = '/Users/yuki/.pyenv/shims/python3.11'
nnoremap <silent><leader>co <cmd>copen<cr>
nnoremap <silent><leader>ccl <cmd>ccl<cr>
nnoremap <silent><leader>n <cmd>noh<cr>

let s:toml_dir = $HOME . '/dotfiles/.config/nvim/plugin/dein/toml'
packadd vim-jetpack
call jetpack#begin()
call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap
call jetpack#load_toml(s:toml_dir . '/dein.toml')
call jetpack#load_toml(s:toml_dir . '/dein_lazy.toml')
call jetpack#load_toml(s:toml_dir . '/ddc.toml')
call jetpack#load_toml(s:toml_dir . '/ddu.toml')
call jetpack#load_toml(s:toml_dir . '/visual.toml')
call jetpack#load_toml(s:toml_dir . '/lsp.toml')
call jetpack#load_toml(s:toml_dir . '/fern.toml')
call jetpack#load_toml(s:toml_dir . '/git.toml')
call jetpack#load_toml(s:toml_dir . '/filetype.toml')
call jetpack#end()
]]

