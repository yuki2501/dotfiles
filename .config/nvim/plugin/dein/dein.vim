" dein.vim
" Repo: https://github.com/Shougo/dein.vim
let s:dein_data_dir        = g:xdg_data_home   . '/nvim/plugin/dein'
let s:dein_repo_dir        = s:dein_data_dir   . '/repos/github.com/Shougo/dein.vim'
let s:dein_config_dir      = g:xdg_config_home . '/nvim/plugin/dein'
let s:dein_cache_dir       = g:xdg_cache_home . '/dein' 
let g:dein#cache_directory = g:xdg_cache_home  . '/dein' . '/.cache'
let s:dein_github_api_token_file = s:dein_config_dir . '/github-api-token.vim' 
let g:dein#ftplugin = {}
"" Auto install
if !isdirectory(s:dein_data_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" Add the dein installation directory into runtimepath
execute 'set rtp+=' . s:dein_repo_dir
" GitHub API Key
if !filereadable(expand(s:dein_github_api_token_file))
    call writefile(["let g:dein#install_github_api_token = ''"],s:dein_github_api_token_file)
endif
if file_readable(expand(s:dein_github_api_token_file))
  let g:dein#install_github_api_token = readfile(s:dein_github_api_token_file)[0]
endif

if dein#min#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)
    let s:toml_dir = s:dein_config_dir . '/toml'
    call dein#load_toml(s:toml_dir . '/dein.toml', { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . '/git.toml', {'lazy': 1 })
    call dein#load_toml(s:toml_dir . '/lsp.toml', { 'lazy': 1 })
    call dein#load_toml(s:toml_dir . '/dein_lazy.toml', { 'lazy': 1 })
    call dein#load_toml(s:toml_dir . '/filetype.toml',{'lazy':1})
    call dein#load_toml(s:toml_dir . '/telescope.toml',{'lazy':1})
    call dein#load_toml(s:toml_dir . '/visual.toml',{'lazy':1})
    call dein#load_toml(s:toml_dir . '/fern.toml', {'lazy':1})
    call dein#load_toml(s:toml_dir . '/ddc.toml', {'lazy':1})
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#check_update(v:true)
  call map(dein#check_clean(),"delete(v:val, 'rf')")
endif

