set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'benmills/vimux'
Plugin 'chriskempson/base16-vim'
Plugin 'pangloss/vim-javascript'

set number
filetype plugin indent on

" USED BUNDLES
Bundle 'gmarik/vundle'
Bundle "scrooloose/nerdtree"
Bundle "airblade/vim-gitgutter"
Bundle "elzr/vim-json"
Bundle 'vim-ruby/vim-ruby'
Bundle "kien/ctrlp.vim"
Bundle "ekalinin/Dockerfile.vim"

" MAIN CONFIG CHANGES
set nocompatible

" (allow unsaved background buffers & remember marks/undo for them)
set hidden

" (remember more commands and search history)
set history=10000

" don't bug me about reloading changed files, just do it
set autoread

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" (make searches case-sensitive only if they contain upper-case characters)
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
set cursorline
" (display incomplete commands)
set showcmd
set ruler
set smartcase
set wrap
set backspace=indent,eol,start

" Newlines without entering insert mode
nmap <CR> o<Esc>

let mapleader = ";"
let g:mapleader = ";"

" COLOURS  ##
" set background=dark

syntax on
colorscheme base16-chalk

set t_Co=256
hi! VertSplit ctermfg=3;14 ctermbg=0 term=NONE

" set line colour for insert mode to make it obvious in my line of sight
" Enable CursorLine
 set cursorline

" Default Colors for CursorLine
highlight  CursorLine ctermfg=None cterm=none

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine cterm=underline

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermfg=None cterm=none

" Set 80 char col colours
set colorcolumn=80
:hi ColorColumn ctermbg=235

" Highlight trailing whitespace, but not during insertion
highlight TrailingWhitespace ctermbg=red guibg=red
au BufEnter    * match TrailingWhitespace /\s\+$/
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Ctrl-HJKL to navigate split panes
":nmap <silent> <C-h> :wincmd h<CR>
":nmap <silent> <C-j> :wincmd j<CR>
":nmap <silent> <C-k> :wincmd k<CR>
":nmap <silent> <C-l> :wincmd l<CR>

" NAVIGATE VIM PANELS
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" OPEN INTO VIM W/ TREE NAV & NO ARGS
map <C-t> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif

" Fold mappings
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" (vim-json hides quotes by default, but i dont like this)
let g:vim_json_syntax_conceal = 0

" Ignore case in searches, unless search contains upper case
set ignorecase
set smartcase

" No swap files!
set noswapfile

" Backup files in a central location, no backup files amongst project.
" Can be a bad idea when editing several files of the same name.
set backupdir=~/.vim/swap
set directory=~/.vim/swap

" add folding support for {...} and [...]
setlocal foldmethod=syntax
setlocal foldlevelstart=20

" RSPEC https://github.com/thoughtbot/vim-rspec
map <Leader>s :w<cr>:call RunCurrentTest()<CR>
map <Leader>S :w<cr>:call RunCurrentLineInTest()<CR>
let g:rspec_command = "!bundle exec rspec --order defined"

" Vimux shortcuts
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" Map CTRL-P Plugin to G for Global

let g:ctrlp_max_height = 16
let g:ctrlp_custom_ignore = ''
let g:ctrlp_custom_ignore .= '/\..*/\|'
let g:ctrlp_custom_ignore .= '/tmp/\|'
let g:ctrlp_custom_ignore .= 'REGEX_TERMINATOR'

nnoremap <leader>gs :CtrlP spec/<cr>
nnoremap <leader>gm :CtrlP app/models/<cr>
nnoremap <leader>gv :CtrlP app/views/<cr>
nnoremap <leader>gc :CtrlP app/controllers/<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\|_test.exs\)$') != -1
  if in_test_file
    call SetTestFile()
    call SetTestPrefix("clear;")

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("rspec ")
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("rspec ")
    elseif match(expand('%'), '_test\.exs$') != -1
      call SetTestRunner("mix test ")
    else
      call SetTestRunner("ruby-Ilib:test ")
    endif
  endif
  call VimuxRunCommand(g:bjo_test_prefix . " " . g:bjo_test_runner. g:bjo_test_file)
endfunction

function! SetTestPrefix(prefix)
  let g:bjo_test_prefix=a:prefix
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  call VimuxRunCommand(g:bjo_test_prefix . " " . g:bjo_test_runner . " " . g:bjo_test_file . ":" . g:bjo_test_file_line)
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

call vundle#end()
filetype plugin indent on


