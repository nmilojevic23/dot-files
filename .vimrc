" .vimrc
set encoding=utf-8

" Load up vim-plug
call plug#begin('~/.vim/plugged')
  Plug 'ap/vim-css-color'     " highlight hex values with their color
  Plug 'dense-analysis/ale'   " asynchronous linting
  Plug 'godlygeek/tabular'    " align stuff... like these vim comments
  Plug 'janko/vim-test'       " run tests inside vim
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
  Plug 'junegunn/fzf.vim'     " fuzzy search for files
  Plug 'mattn/webapi-vim'
  Plug 'morhetz/gruvbox'      " current colorscheme
  Plug 'scrooloose/nerdtree'  " file browser
  Plug 'sheerun/vim-polyglot' " syntax highlighting for many languages
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary' " comment stuff out, like these comments
  Plug 'tpope/vim-endwise'    " match do/end, brackets, etc
  Plug 'tpope/vim-fugitive'   " git wrapper
  Plug 'tpope/vim-rhubarb'    " git(hub) wrapper - open on GitHub
  Plug 'tpope/vim-surround'   " change and add surrounds, []()
  Plug 'vimwiki/vimwiki'      " my own personal wiki
call plug#end()

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set termguicolors                 " show me all the colors please
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set relativenumber                " show relative line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set timeoutlen=500                " decrease timeout for 'jk' mapping
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
runtime macros/matchit.vim        " use % to jump between start/end of methods

""""""""""""""""""""""
" BEGIN WINDOWS CONFIG
""""""""""""""""""""""
behave mswin

if has("clipboard")
  " CTRL-X and SHIFT-Del are Cut
  vnoremap <C-X> "+x
  vnoremap <S-Del> "+x

  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C> "+y
  vnoremap <C-Insert> "+y

  " CTRL-V and SHIFT-Insert are Paste
  map <C-V> "+gP
  map <S-Insert> "+gP

  cmap <C-V> <C-R>+
  cmap <S-Insert> <C-R>+
endif

if 1
  exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
  exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
endif
""""""""""""""""""""""
" END WINDOWS CONFIG
""""""""""""""""""""""

" put git status, column/row number, total lines, and percentage in status
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

" setup color scheme
set background=dark
colorscheme gruvbox

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" set leader key to comma
let mapleader = ","

" NERDTree config
nmap <leader>g :NERDTreeToggle<cr>
nmap <leader>G :NERDTreeRefreshRoot<cr>

" Ale configuation
let g:ale_set_highlights=0

" vimwiki configuration
let g:vimwiki_list = [{'path': '~/Dropbox/notes', 'path_html': '~/Dropbox/notes/html', 'ext': '.md', 'auto_export': 0, 'syntax': 'markdown'}]

" FZF config
let $FZF_DEFAULT_COMMAND = 'rg --files'
nmap <Leader>f :Files<CR>

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" vim test config
let g:test#preserve_screen = 1
nmap <silent> <leader>t :TestFile<cr>
nmap <silent> <leader>T :TestNearest<cr>

" if using nvim terminal, re-map normal mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" map jk to escape (thanks touchbar)
inoremap jk <Esc>
inoremap kj <Esc>

" map escape to exit terminal insert mode
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" unmap ex mode: 'Type visual to go into Normal mode.'
nnoremap Q <nop>

" map . in visual mode
vnoremap . :norm.<cr>

" map markdown preview
nmap <leader>m :!open -a "Marked 2" "%"<cr><cr>

" map git commands
nmap <leader>b :Gblame<cr>
nmap <leader>l :split \| terminal git log -p %<cr>
nmap <leader>d :split \| terminal git diff %<cr>

" map file search
nmap <leader>a :Rg<space>

" clear the command line and search highlighting
noremap <C-l> :nohlsearch<CR>

" toggle spell check with `
nmap ` :setlocal spell! spelllang=en_us<cr>

" add :Plain command for converting text to plaintext
command! Plain execute "%s/[’‘]/'/ge | %s/[“”]/\"/ge | %s/—/-/ge | %s/–/-/ge"

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
endif

" jump to last position in file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
nmap <leader>n :call RenameFile()<cr>
