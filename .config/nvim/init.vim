""" Neovim provider """
" Doc: https://neovim.io/doc/user/provider.html
let g:loaded_python_provider = 1
let g:python_host_prog       = ''
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
"clipboard config for win
"nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
"vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
"nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
"vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
"clipboard config for mac
"set clipboard = unnamedplus
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
""" Plugin """
" dein.vim
" Repo: https://github.com/Shougo/dein.vim
exec 'source' g:xdg_config_home . '/nvim/plugin/dein/dein.vim'

"config for vimtex
"let g:vimtex_fold_envs = 0
"let g:vimtex_view_general_viewer = 'displayline'
"let g:vimtex_view_general_options = '-r @line @pdf @tex'
"let g:vimtex_compiler_latexmk = {
"      \ 'options' : [
"      \   '-verbose',
"      \   '-file-line-error',
"      \   '-synctex=1',
"      \   '-interaction=nonstopmode',
"      \ ]}
let mapleader = ";"
let maplocalleader = ","
inoremap <silent> jj <ESC>
let g:tmuxline_preset = {
  \'a'    : '#S',
  \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
  \'win'  : ['#I', '#W'],
  \'cwin' : ['#I', '#W', '#F'],
  \'x'    : '#(date)',
  \'y'    : ['%R', '%a', '%Y'],
  \'z'    : '#H'}
let g:tmuxline_theme = 'solarized'
