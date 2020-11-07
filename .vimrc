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

" Download and install Vundle (NOT cross platform).
if empty(glob(
    \ '$HOME/.vim/bundle/Vundle.vim'))
  execute '!git clone ' .
    \ 'https://github.com/VundleVim/Vundle.vim.git'
    \ ' ~/.vim/bundle/Vundle.vim' .
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" => Sane defaults --------------------------------------------------------
set encoding=utf-8

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

" to speed things up a bit
set ttimeoutlen=10

" permits using h and l to move between line when reaching the start
" and the end of a line, respectively
set whichwrap=h,l

" do not recognize numbers starting with a zero as octal
set nrformats-=octal

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

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

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
Plug 'habamax/vim-godot'

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

" VIMWIKI OPTIONS
let g:vimwiki_list = [{
  \ 'template_path': '$HOME/vimwiki',
  \ 'template_default': 'def_template',
  \ 'template_ext': '.html'}]
" let g:vimwiki_folding = 'expr'      " Enable folding.

" => godot-vim options --------------------------------------------------------------------------------
let g:godot_executable='$HOME/Gamedev/godot'

func! GodotSettings() abort
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
    nnoremap <buffer> <Leader>gl :GodotRunLast<CR>
    nnoremap <buffer> <Leader>gm :GodotRun<CR>
    nnoremap <buffer> <Leader>g :GodotRunCurrent<CR>
    nnoremap <buffer> <Leader>gf :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end

" => key bindings --------------------------------------------------------------------------------------
" Leader
let mapleader = " "

" make using the clipboard more easyyy
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" easy access to .vimrc file
noremap <Leader>rc :sp $MYVIMRC<CR>

" easy fzf use
noremap <Leader>f :Files<CR>
noremap <Leader>ag :Ag<CR>

" Save more quickly
nnoremap <Leader>s :w<CR>

" easy TOC
map \T :VimwikiTOC<CR>

" insta make
nnoremap <silent> <Leader>mk :make<Enter><Enter><Enter>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" => the YouCompleteMe bundle ---------------------------------------------------------------------------------------------------------

" filetype off " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Vundle plugins
call vundle#begin()
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

Plugin 'ycm-core/YouCompleteMe' " the sole reason I installed Vundle to begin with
call vundle#end()

" options for you complete me
set completeopt-=preview

" => source
" -------------------------------------------------------------------------------------------------------------

source /home/isaac/GitHub/lsp-examples/vimrc.generated
