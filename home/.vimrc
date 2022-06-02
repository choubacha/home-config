set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" ALE is an asynchronous linter.
Plug 'dense-analysis/ale'

" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
Plug 'editorconfig/editorconfig-vim'

" Plug 'ycm-core/YouCompleteMe'

" Ruby
Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rails'
Plug 'noprompt/vim-yardoc'

" Rspec
Plug 'rlue/vim-fold-rspec'
Plug 'keith/rspec.vim'

Plug 'vim-test/vim-test'

" HTML syntax
Plug 'tpope/vim-haml'
Plug 'slim-template/vim-slim'

" YAML handling
Plug 'stephpy/vim-yaml'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'glench/vim-jinja2-syntax'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'kchmck/vim-coffee-script'

Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

Plug 'rust-lang/rust.vim'

Plug 'StanAngeloff/php.vim'
Plug 'dsawardekar/wordpress.vim'
Plug 'leafgarland/typescript-vim'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call plug#end() " required

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

set foldmethod=syntax   " fold based on syntax
set foldlevel=100       " Start with open folds
highlight Folded guibg=grey guifg=blue
highlight FoldColumn guibg=darkgrey guifg=white

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

set scrolloff=4         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"
"
" ================ Highlighting ====================
highlight OverLength cterm=underline
match OverLength /\%101v.\+/
set hlsearch

"
"
" ================= Focus =============================
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=101
  autocmd WinLeave * set colorcolumn=0
augroup END
set colorcolumn=101

"
" ================= Clear search with esc ==============
nnoremap <silent> <esc><esc> :nohl<return><esc>
nnoremap <c-b> :CtrlPBuffer<return>

"
" ================== ALE ====================
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'ruby': ['rubocop'],
      \}

let g:ale_linters = {
      \ 'ruby': ['sorbet', 'rubocop'],
      \}
" Setting to bundle will have it use bundle
let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_ruby_sorbet_executable = 'bundle'

let g:ale_ruby_rubocop_auto_correct_all = 1

let g:ale_lsp_show_message_severity = 'information'

let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_rls_config = {
      \ 'rust' : {
      \   'clippy_preference': 'on'
      \  }
      \}
let g:ale_fix_on_save = 1

" Turns on rust formatting without ale
let g:rustfmt_autosave = 1

" These commands are useful if you don't want to autoformat a file on save
" but cannot remember the variable.
command ALEDisableAutofixCustom let b:ale_fix_on_save = 0
command ALEEnableAutofixCustom let b:ale_fix_on_save = 1

" When there is an error, the highlight is linked to the SpellBad highlight
" group. So this changes it to an underline without a background.
highlight SpellBad cterm=underline ctermbg=NONE ctermul=Red
highlight SpellCap cterm=underline ctermbg=NONE ctermul=Red
highlight SpellRare cterm=underline ctermbg=NONE ctermul=Red
highlight SpellLocal cterm=underline ctermbg=NONE ctermul=Red
"
" ================== commands ===============
command RubyHashFix %s/:\([a-zA-Z0-9_]\+\)\s*=>\s*/\1: /gc
command RspecShould %s/\([a-zA-Z0-9_.-]\+\)\.should\s*==\s*/expect(\1).to eq /gc
command RspecShouldNot %s/\([a-zA-Z0-9_.-]\+\)\.should_not\s*==\s*/expect(\1).to_not eq /gc
command NgHoist %s/^\(\s*\)\$scope\.\(\S*\)\s*=\s*function(\(.*\))\s*{$/\1$scope.\2 = \2;\r\1function \2(\3) {/gc

"
" ================== Clipboard ==============
set clipboard=unnamed

"
" =================== Status =================
set laststatus=2 " always show.

"
" =================== Spell ==================

set spell spelllang=en_us

"
" =================== Markdown ===============
augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
  autocmd FileType markdown set textwidth=100
augroup END
