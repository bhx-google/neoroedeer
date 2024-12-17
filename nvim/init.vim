" Plugins

lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  use 'vimwiki/vimwiki'
  use 'frankier/neovim-colors-solarized-truecolor-only'
  use 'vim-airline/vim-airline'
  use({'nvim-tree/nvim-tree.lua',
      requires = 'nvim-tree/nvim-web-devicons'})
  use 'scrooloose/nerdcommenter'
  use 'frace/vim-bubbles'
  use 'vhdirk/vim-cmake'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'mileszs/ack.vim'
  use 'MarcWeber/vim-addon-mw-utils'
  use 'tomtom/tlib_vim'
  use 'garbas/vim-snipmate'
  use 'honza/vim-snippets'
  use 'easymotion/vim-easymotion'
  use 'tpope/vim-fugitive'
  use "sindrets/diffview.nvim"
  use 'airblade/vim-gitgutter'
  use 'mhinz/neovim-remote'
  use 'lervag/vimtex'
  use 'bkad/CamelCaseMotion'
  use 'nvim-tree/nvim-web-devicons'
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.2',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/vim-vsnip")
  use("neovim/nvim-lspconfig")
  use("onsails/lspkind.nvim")
  use("adigitoleo/haunt.nvim")
  use("romgrk/barbar.nvim")
  use("ludovicchabant/vim-lawrencium")

  -- Diagnostics
  use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"})

  use 'sso://googler@user/vintharas/telescope-codesearch.nvim'
  use 'sso://googler@user/tylersaunders/telescope-fig.nvim'
  use 'sso://googler@user/aktau/telescope-citc.nvim'
  use {
    'sso://@user/vvvv/ai.nvim',
    requires = {
      'rcarriga/nvim-notify',
      'nvim-lua/plenary.nvim'
    }
  }
  use {
    'sso://@user/chmnchiang/google-comments', requires = { 'nvim-lua/plenary.nvim' }
  }
  use({
    'sso://googler@user/vicentecaycedo/cmp-buganizer',
    requires = { {'nvim-lua/plenary.nvim'} }
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
EOF

lua << EOF
-- CiderLSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }
require("lsp")

-- Diagnostics
require("diagnostics")
EOF

lua <<EOF

require("haunt").setup({
  window = {
    width_frac = 0.9,
    height_frac = 0.9,
    winblend = 0,
  }
})

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "vim_vsnip" },
    { name = "buffer",   keyword_length = 5 },
    { name = "buganizer" },
  },
})

vim.api.nvim_set_keymap('n', '<leader>sf',
  [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]],
  { noremap = true, silent=true }
)

vim.api.nvim_set_keymap('n', '<leader>tm',
  [[<cmd>:HauntTerm -t zsh<CR>]],
  { noremap = true, silent=true }
)

-- Search using codesearch queries.
vim.api.nvim_set_keymap('n', '<leader>ss',
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]],
  { noremap = true, silent=true }
)

vim.api.nvim_set_keymap('n', '<leader>sm',
  [[<cmd>lua require('telescope').extensions.citc.modified{}<CR>]],
  { noremap = true, silent=true }
)

vim.api.nvim_set_keymap('n', '<leader>sw',
  [[<cmd>lua require('telescope').extensions.citc.workspaces{}<CR>]],
  { noremap = true, silent=true }
)
vim.api.nvim_set_keymap('n', '<leader>tt',
  [[<cmd>NvimTreeToggle<CR>]],
  { noremap = true, silent=true }
)

vim.api.nvim_set_keymap('n', '<leader>tf',
  [[<cmd>NvimTreeFindFile<CR>]],
  { noremap = true, silent=true }
)


require('telescope').setup {
  defaults =  {
    layout_strategy = 'vertical',
    -- Common paths in google3 repos are collapsed following the example of Cider
    -- It is nice to keep this as a user config rather than part of
    -- telescope-codesearch because it can be reused by other telescope pickers.
    path_display = function(opts, path)
      -- Do common substitutions
      path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
      path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
      path = path:gsub("^google3/analysis/conduit", "g3/a/c", 1)
      path = path:gsub("^google3/analysis/deepblue", "g3/a/d", 1)
      path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
      path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
      path = path:gsub("^google3/", "g3/", 1)

      -- Do truncation. This allows us to combine our custom display formatter
      -- with the built-in truncation.
      -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
      -- Here we are manually propagating this value between new_opts and opts.
      -- We can make this cleaner and more complicated using metatables :)
      local new_opts = {
        path_display = {
          truncate = true,
        },
        __length = opts.__length,
      }
      path = require('telescope.utils').transform_path(new_opts, path)
      opts.__length = new_opts.__length
      return path
    end,
  },
  extensions = { -- this block is optional, and if omitted, defaults will be used
    codesearch = {
      experimental = true           -- enable results from google3/experimental
    }
  }
}

local function nvim_tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  -- override a default
  -- vim.keymap.set('n', '<leader>n', api.tree.reload,                       opts('Refresh'))

  -- add your mappings
  -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  ---
end

require("nvim-tree").setup({
  ---
  on_attach = nvim_tree_on_attach,
  ---
})

require('google.comments').setup()

vim.api.nvim_set_keymap('n', ']lc',
  [[<Cmd>lua require('google.comments').goto_next_comment()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lc',
  [[<Cmd>lua require('google.comments').goto_prev_comment()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lc',
  [[<Cmd>lua require('google.comments').toggle_line_comments()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ac',
  [[<Cmd>lua require('google.comments').show_all_comments()<CR>]],
  { noremap = true, silent = true })

EOF

let g:airline_powerline_fonts = 1
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'
let g:vimtex_compiler_progname = 'nvr'
"let g:vimtex_view_method = 'mupdf'
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimwiki_list = [{
  \ 'auto_export': 0,
  \ 'automatic_nested_syntaxes':1,
  \ 'path_html': '$HOME/notes/wiki/_site',
  \ 'path': '$HOME/notes/wiki/content',
  \ 'template_path': '$HOME/notes/wiki/templates/',
  \ 'syntax': 'markdown',
  \ 'index': '_index',
  \ 'ext':'.md',
  \ 'template_default':'markdown',
  \ 'custom_wiki2html': '$HOME/notes/wiki/wiki2html.sh',
  \ 'template_ext':'.html'
\}]

" Appearance

set termguicolors
set background=light
colorscheme solarized
set number
set ruler
set mouse=a
set modelineexpr

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" file type
syntax enable
filetype plugin indent on
au FileType make setlocal noexpandtab

" file type specific tabs
au FileType python setlocal tabstop=4 shiftwidth=4
au FileType ruby setlocal tabstop=2 shiftwidth=2
au FileType scala setlocal tabstop=2 shiftwidth=2


au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal! g`\"" | endif

" indent and linebreaks
set tabstop=2
set shiftwidth=2
set expandtab
set nowrap
set list listchars=tab:▸-,trail:·
set listchars+=extends:>
set listchars+=precedes:<

" search

set hlsearch
set incsearch
set ignorecase

set backupdir^=~/.config/nvim/_backup//    " where to put backup files.
set directory^=~/.config/nvim/_temp//      " where to put swap files.
set smartcase

" key map
let mapleader = "\\"

let &makeprg = 'cmake --build build'
map <F9> :HauntTerm<CR>

" mappings taken from janus

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" camel motion key to comma
let g:camelcasemotion_key = ','

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

""
"" Command-Line Mappings
""

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"
