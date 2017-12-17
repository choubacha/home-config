set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/syntastic'

Plugin 'vim-ruby/vim-ruby'
Plugin 'bbatsov/rubocop'
Plugin 'ngmy/vim-rubocop'
Plugin 'slim-template/vim-slim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-haml'

Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'

Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

Plugin 'kien/ctrlp.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'StanAngeloff/php.vim'
Plugin 'dsawardekar/wordpress.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

" This will show the little row,col at the bottom
set ruler
" set cursorline

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

autocmd FileType php setlocal noexpandtab

" Display tabs and trailing spaces visually
set list listchars=tab:│\ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ windox sizing ====================
set winheight=30
set winminheight=5
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"
"
" ================ Highlighting ====================
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
set hlsearch

"
"
" ================= Focus =============================
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=101
  autocmd WinLeave * set colorcolumn=0
augroup END

"
" ================= Clear search with esc ==============
nnoremap <silent> <esc><esc> :nohl<return><esc>
nnoremap <c-b> :CtrlPBuffer<return>

"
" ================== CTRL P ==================
let g:ctrlp_clear_cache_on_exit = 0

"
" ================== Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump=0
let g:syntastic_ruby_checkers=['rubocop', 'mri']
let g:syntastic_ruby_rubocop_quiet_messages = { "level" : [] }

" Mark syntax errors with :signs
let g:syntastic_enable_signs=1

"
" ================== rust racer =============
set hidden
let g:racer_cmd = "racer"
let $RUST_SRC_PATH="/usr/local/src/rust/src"

"
"" ================= Autoformat =============
noremap <F3> :Autoformat<CR>

"
" ================== commands ===============
command RubyHashFix %s/:\([a-zA-Z0-9_]\+\)\s*=>\s*/\1: /gc
command RspecShould %s/\([a-zA-Z0-9_.-]\+\)\.should\s*==\s*/expect(\1).to eq /gc
command RspecShouldNot %s/\([a-zA-Z0-9_.-]\+\)\.should_not\s*==\s*/expect(\1).to_not eq /gc
command NgHoist %s/^\(\s*\)\$scope\.\(\S*\)\s*=\s*function(\(.*\))\s*{$/\1$scope.\2 = \2;\r\1function \2(\3) {/gc
