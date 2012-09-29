" vim: set et sw=4 ts=4 sts=4 fdm=marker ff=unix fenc=utf8
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 
" let Vundle manage Vundle
" required! <br>
Bundle 'gmarik/vundle'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'vim-scripts/mru.vim'
Bundle 'ervandew/supertab'
Bundle 'FencView.vim'
Bundle 'scratch.vim'
Bundle 'molokai'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'ack.vim'
"Bundle 'php.vim-for-php5'
"Bundle 'phpcomplete.vim'
"Bundle 'Command-T'
Bundle 'buftabs'
Bundle 'tpope/vim-fugitive'
Bundle 'DBGPavim'
 
filetype plugin indent on     " required! 

set linebreak
set textwidth=100
set nocompatible
set history=400
set ruler
set number
set incsearch
set showmatch
set expandtab
set noerrorbells
set novisualbell
"set vb t_vb= "close visual bell
set t_Co=256

set foldenable
set foldmethod=indent
set foldlevel=100
set foldopen-=search
set foldopen-=undo
set autochdir
set tags=~/.vim/tags/sugarcrmTag



set tabstop=4
set shiftwidth=4
"set noswapfile
set smarttab
set smartindent
set autoindent
set cindent
set wrap
set autoread
set cmdheight=1
set showtabline=1 
"set clipboard+=unnamed
set tabpagemax=20
set laststatus=2
"set statusline=\ [File]\ %F%m%r%h\ %w\ [PWD]\ %r%{CurrectDir()}%h\ \ %=[Line]\ %l,%c\ %=\ %P
"set statusline=%<%f\ %h%m%r%!{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set statusline=\ [File]\ %F%m%r%h\ %w\ %{fugitive#statusline()}\ [PWD]\ %r%{CurrectDir()}%h\ \ %=[Line]\ %l,%c\ %=\ %P
set fillchars+=stl:\ ,stlnc:\

set hlsearch
set encoding=utf-8
set termencoding=utf-8
set fencs=utf-8,gbk
set ignorecase
set smartcase
set gdefault
set colorcolumn=0





function! CurrectDir()
    let curdir = substitute(getcwd(), "", "", "g")
    return curdir
endfunction

if has("multi_byte")
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif 
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

if has("gui_running")
    set guioptions=r
    set background=light
    colorscheme molokai
    set cursorline
    if has("win32")
        set guifont=Consolas:h10:cANSI
        "set guifont=Ubuntu\ Mono\ 10
        au GUIEnter * simalt ~x
    else
        "set guifont=Consolas:h10:cANSI
        "set guifont=Ubuntu\ Mono\ 11
        set guifont=WenQuanYi\ Micro\ Hei\ Mono\ 10
        "set guifont=Andale\ Mono\ for\ Powerline\ 10
        "set lines=999 columns=999
    endif
else
    "colorscheme murphy
    colorscheme pablo
    "colorscheme black_angus
endif

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

        autocmd QuickFixCmdPost *grep* cwindow  "for plugin: fugitive
    augroup END
endif

let treeExplVertical=1
let treeExplWinSize=35
let treeExplDirSort=1
let treeExplNoList=1

let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
let Tlist_Enable_Fold_Column=0
let g:Powerline_symbols = 'fancy'
let g:buftabs_only_basename=1
let g:buftabs_active_highlight_group="Visual"

let mapleader=","
"=======================dbgp config =================================
let g:dbgPavimPort = 9001
let g:dbgPavimBreakAtEntry = 0
let g:dbgPavimMaxData = 20480
let g:dbgPavimMaxDepth = 24

nnoremap <leader>B :Bp<cr>
nnoremap <leader>L :Bl<cr>
"=======================dbgp config =================================

nnoremap <leader><space> :noh<cr> 
nnoremap <leader><tab> :Scratch<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>D :bd!<cr>
inoremap jj <ESC>
"remove search results
nnoremap <tab> %
vnoremap <tab> %
nnoremap <leader>ff :b#<CR>
nnoremap <leader>FF :set hidden<CR>:b#<CR>
nnoremap <leader>hh :set hidden<CR>
nnoremap <silent> <leader>jf :call g:Jsbeautify()<cr>


let g:BufferListWidth = 35                                              
let g:BufferListMaxWidth = 50                                      
hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold   
hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE 

map <silent><leader>ee :e ~/.vimrc<CR>
map <silent><leader>rr :MRU<CR>
map <silent><leader>cc :call PhpDoc()<CR>
map <silent><leader>ss :source ~/.vimrc<CR>
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"for sfa git build
au BufWritePost $GITDIR/sugarcrm/* silent !buildfile_vim.sh "%:p"

" key stock
map tn :tabnext<cr>
map tp :tabprevious<cr>
map td :tabnew .<cr>
map te :tabedit
map tc :tabclose<cr>


map <F2> :Explore<cr>
map <F3> :NERDTreeToggle<cr>
map <F4> :Tlist<cr>
map <F12> <Esc>:Tlist<CR><C-W>h<C-W>s:NERDTreeToggle<CR>:set nonu<CR><C-W>l
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


set nobackup
set nowritebackup

command! Sudosave :w !sudo tee %
