" Plugins

lua <<EOF
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
  -- use 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  use 'scrooloose/nerdcommenter'
  use 'frace/vim-bubbles'
  use 'vhdirk/vim-cmake'
  use 'tpope/vim-unimpaired'
  use 'mileszs/ack.vim'
  use 'MarcWeber/vim-addon-mw-utils'
  use 'tomtom/tlib_vim'
  use 'garbas/vim-snipmate'
  use 'honza/vim-snippets'
  use 'easymotion/vim-easymotion'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'mhinz/neovim-remote'
  use 'lervag/vimtex'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
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
color solarized
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
set tabstop=4
set shiftwidth=4
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
map <leader>n :NERDTreeToggle<CR>

let &makeprg = 'cmake --build build'
map <F9> :make<CR>

" mappings taken from janus

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

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
