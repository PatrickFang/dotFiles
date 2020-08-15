set nocompatible              " be iMproved, required
set number
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"""" Installed by myself for fuzzy search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'janko-m/vim-test'
Bundle 'vim-ruby/vim-ruby'
" All of your Plugins must be added before the following line
call vundle#end()            " required

set runtimepath+=~/.vim
execute pathogen#infect()


" Keymapping settings
let mapleader = ","

" Reload VIMRC
nmap <leader>r :source $MYVIMRC<cr>

" Color scheme settings.
syntax on

" Set vim defaults
set encoding=utf8
set nocompatible
filetype plugin indent on
nnoremap j gj
nnoremap k gk

"Remove Menu and Toolbars from GVIM
set guioptions-=m
set guioptions-=T

" Make Y behave like other capitals
map Y y$

" Toggle - comment, uses Vim-commentary
nmap <C-\> gcc<ESC>
vmap <C-\> gcc<ESC>

" No swap files and other basic settings
set nobackup
set noswapfile

" Disable quit<enter> message
nnoremap <C-c> <silent> <C-c>

" Spell check settings
" set spell
set spellfile=~/.vim/spell/mySpellFile.en.utf-8.add
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"""""""""" Airline Config
let g:airline_left_sep  = ''
let g:airline_right_sep = ''

set clipboard=unnamed " Share the clipboard with OS
set scrolloff=3
set autoindent
set complete-=i
set smarttab
set showmode
set nrformats-=octal
set showcmd
set shiftround
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start " backspace through everything in insert mode
set laststatus=2
set expandtab " Use spaces, not tabs
set tabstop=2 shiftwidth=2
" set number
set modelines=0 " Prevent security exploits having to do with modelines
set mouse=n " Mouse usage enabled in normal mode.
set so=14 " Keep cursor away from edges of screen.
set display+=lastline
set tags=./tags;

set ttimeout
set ttimeoutlen=50

"""""""""" File Navigation
nmap <leader>f :CtrlPMixed<CR>
nmap <leader>b :CtrlPBuffer<CR>
" %% gives you the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
"""""""""" Split Window Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Font setting
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 16
  elseif has("gui_win32")
    set guifont=Consolas:h16:cANSI
  else
    set guifont=Consolas:h16
  endif
endif

if &listchars ==# 'eol:$'
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
  endif
endif

" Tame searching / moving
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
" Use <C-L> to clear the highlighting of :set hlsearch.
set hlsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Handle long lines correctly
set wrap
set textwidth=79
set formatoptions=qrn1

" Vim surround shortcuts for erb files, - for <% %>, and = for <%= %>
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

"""""""""" Rename current file, via Gary Bernhardt <3 <3 <3
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    exec ':bd ' . old_name
    redraw!
  endif
endfunction

map <leader>, :call RenameFile()<cr>

"""""""""" Execute file if we know how
function! ExecuteFile(filename)
  :w
  :silent !clear
  if match(a:filename, 'test\.rb$') != -1
    exec ":!ruby " . a:filename
  elseif match(a:filename, '\.rb$') != -1
    exec ":!ruby " . a:filename
  elseif match(a:filename, '\.js$') != -1
    exec ":!node " . a:filename
  elseif match(a:filename, '\.sh$') != -1
    exec ":!bash " . a:filename
  elseif match(a:filename, '\.tex$') != -1
    exec ":!make "
  elseif match(a:filename, 'makefile$') != -1
    exec ":!make "
  else
    exec ":!echo \"Don't know how to execute: \"" . a:filename
  end
endfunction

map <leader>e :call ExecuteFile(expand("%"))<cr>

"""""""""" Replace fancy characters with standard ones
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

"""""""""" LineBreakAt
" Insert a newline after each specified string (or before if use '!').
" :LineBreakAt ( )  Insert newline after each '(' and ')' in current line.
" :%LineBreakAt ( ) Same, whole buffer.
" :LineBreakAt! ( ) Insert newline before each '(' and ')' in current line.
" :%LineBreakAt Insert newline after each occurrence of last-used search pattern.
" :%LineBreakAt!  Insert newline before each occurrence of last-used search pattern.
function! LineBreakAt(bang, ...) range
  let save_search = @/
  if empty(a:bang)
    let before = ''
    let after = '\ze.'
    let repl = '&\r'
  else
    let before = '.\zs'
    let after = ''
    let repl = '\r&'
  endif
  let pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~[')")
  let find = empty(pat_list) ? @/ : join(pat_list, '\|')
  let find = before . '\%(' . find . '\)' . after
  " Example: 10,20s/\%(arg1\|arg2\|arg3\)\ze./&\r/ge
  execute a:firstline . ',' . a:lastline . 's/'. find . '/' . repl . '/ge'
  let @/ = save_search
endfunction
command! -bang -nargs=* -range LineBreakAt <line1>,<line2>call LineBreakAt('<bang>', <f-args>)

"""""""""" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind Leader g to grep word under cursor
  nnoremap <leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

" bind Leader G to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader>G :Ag<SPACE>

" fzf
nnoremap <C-P> :Files<cr>
nnoremap <C-B> :Buffers<cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "dispatch"
