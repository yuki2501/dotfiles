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
set shell=/bin/sh
" Indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
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
nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
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

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
""" Plugin """
" dein.vim
" Repo: https://github.com/Shougo/dein.vim
exec 'source' g:xdg_config_home . '/nvim/plugin/dein/dein.vim'
