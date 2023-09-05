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

vim.cmd[[
set runtimepath+=~/nvim-plugin/ddc-coq
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
]]

--[[
# Change colorschemes by active/inactive windows

This is a simplified version, and may cause performance issue if so many windows are open.

## Requirements:

- nvim >= 0.8
- plugins
    - folke/styler.nvim
    - catppuccin/nvim
    - EdenEast/nightfox.nvim
]]
-- 設定
-- styler.set_themeに与えるカラースキームはLua製な必要あり
INACTIVE_COLORSCHEME = 'nordfox'


-- 非アクティブウィンドウ向けの関数
local function inactivate(win)
  -- skip for certain situations
  if not vim.api.nvim_win_is_valid(win) then return end
  if vim.api.nvim_win_get_config(win).relative ~= "" then return end

  -- apply colorscheme if not yet
  if (vim.w[win].theme or {}).colorscheme ~= INACTIVE_COLORSCHEME then
    require('styler').set_theme(win, { colorscheme = INACTIVE_COLORSCHEME })
  end
end

-- autocmdの発行
vim.api.nvim_create_autocmd(
  { 'WinLeave', 'WinNew' },
  {
    group = vim.api.nvim_create_augroup('styler-nvim-custom', {}),
    callback = function(_)
      local win_event = vim.api.nvim_get_current_win()
      vim.schedule(function()
        local win_pre = vim.fn.win_getid(vim.fn.winnr('#'))
        local win_cursor = vim.api.nvim_get_current_win()

        -- カーソル位置のウィンドウでstyler.nvimを無効化する
        if (vim.w[win_cursor].theme or {}).colorscheme then
          require('styler').clear(win_cursor)
        end

        -- 直前のウィンドウにカーソルがなければinactivate
        if win_pre ~= 0 and win_pre ~= win_cursor then
          inactivate(win_pre)
        end

        -- イベントを発行したウィンドウにカーソルがなければinactivate
        if win_event ~= win_cursor then
          inactivate(win_event)
        end
      end)
    end
  }
)
