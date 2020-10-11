" Author: Antônio Isaac
" Description: Personal .vimrc file
"
" All the plugins are managed via vim-plug
" To install the plugins type :PlugInstall
" To update the plugins type :PlugUpdate
" Leaderkey is spacebar

" => Pre-load ------------------------------------------------------------- {{{1

filetype plugin indent on

" Download and install vim-plug (cross platform).
if empty(glob(
    \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
    \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') .
    \ '/autoload/plug.vim --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" => Sane defaults --------------------------------------------------------
set encoding=utf-8

" Leader
let mapleader = " "

filetype plugin on
set nocompatible
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline

" permits using h and l to move between line when reaching the start
" and the end of a line, respectively
set whichwrap=h,l

" do not recognize numbers starting with a zero as octal
set nrformats-=octal

" make using the clipboard more easyyy
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" easy access to .vimrc file
noremap <Leader>rc :sp $MYVIMRC<CR>

" easy fzf use
noremap <Leader>f :Files<CR>
noremap <Leader>ag :Ag<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" easy TOC
map \T :VimwikiTOC<CR>

" insta make
nnoremap <silent> <Leader>mk :make<Enter><Enter><Enter>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Aesthetic
set background=dark
colorscheme industry

" => vim-plug plugins ----------------------------------------------------- {{{1

" For vimwiki to utilize vim-table properly
let g:table_mode_corner='|'

call plug#begin()

Plug 'vimwiki/vimwiki'
Plug 'danilamihailov/vim-tips-wiki'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Soft word wrap
set linebreak

" Make soft line breaks much better looking.
set breakindent

" Pretty soft break character.
let &showbreak = '> '

" Use Unix as the standart file type.
set ffs=unix,dos,mac

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight=2
endif

" Exit terminal mode with double Esc tap.
if has('nvim')
  tnoremap <esc><esc> <c-\><c-n>
endif

" Disable line numbers in terminal.
au CursorMoved * if &buftype == 'terminal' | set nonumber | endif

" godot options
let g:godot_executable='$HOME/GameDev/Godot_v3.2.1-stable_x11.64'
" VIMWIKI OPTIONS
let g:vimwiki_list = [{
  \ 'template_path': '$HOME/vimwiki',
  \ 'template_default': 'def_template',
  \ 'template_ext': '.html'}]
" let g:vimwiki_folding = 'expr'      " Enable folding.
