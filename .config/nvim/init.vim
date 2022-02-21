""" Neovim provider """
" Doc: https://neovim.io/doc/user/provider.html
" Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
let g:xdg_config_home = !empty($XDG_CONFIG_HOME)
    \ ? $XDG_CONFIG_HOME
    \ : $HOME . '/.config'
let g:xdg_cache_home  = !empty($XDG_CACHE_HOME)
    \ ? $XDG_CACHE_HOME
    \ : $HOME . '/.cache'
let g:xdg_data_home   = !empty($XDG_DATA_HOME)
    \ ? $XDG_DATA_HOME
    \ : $HOME . '/.local/share'

""" Options """
set shell=/usr/local/bin/zsh
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1
" Indent
set tabstop=2
set shiftwidth=2 
set softtabstop=2
set expandtab
set autoindent
set smartindent
" Split
set splitright
set splitbelow
" Look and Feel
set termguicolors
set cursorcolumn
set cursorline
set colorcolumn=80
set number
set relativenumber
set pumblend=15
set winblend=15
" All previous modes
set mouse=a
" Automatically wrap left and right
set whichwrap=b,s,h,l,<,>,[,]
"set clipboard = unnamedplus
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
let mapleader = ";"
inoremap <silent> jj <ESC>



""" Plugin """
" dein.vim
" Repo: https://github.com/Shougo/dein.vim
exec 'source' g:xdg_config_home . '/nvim/plugin/dein/dein.vim'
function! s:LazyLoadPlugs(timer) abort
  " save current position by marking Z because plug#load reloads current buffer
  normal! mZ
  call dein#add('nvim-lua/plenary.nvim')
  call dein#config('plenary.nvim',{'lazy':1,})
  call dein#add('shaunsingh/nord.nvim')
  call dein#config('nord.nvim',{'lazy':1,})
  call dein#add('kyazdani42/nvim-web-devicons')
  call dein#config('nvim-web-devicons',{'lazy':0,})
  call dein#add('nvim-lualine/lualine.nvim')
  call dein#config('lualine.nvim',{'lazy':1,'on_lua':'nord',})
  normal! g`Z
  delmarks Z

lua << EOF
  -- Example config in lua
  vim.g.nord_contrast = true
  vim.g.nord_borders = false
  vim.g.nord_disable_background = true
  vim.g.nord_italic = false
  -- Load the colorscheme
  require('nord').set()
  require('lualine').setup{
    options = {theme = 'nord'}
  }

EOF
endfunction
call timer_start(40, function("s:LazyLoadPlugs"))
