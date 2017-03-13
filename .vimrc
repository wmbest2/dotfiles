" vim:fdm=marker
" ENV Vars {{{
let $GOPATH=expand('$GOPATH')
let $POWERLINE_HOME=expand('$POWERLINE_HOME')
" }}}
" Vundle Setup {{{
"
" download Vundle if missing
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme) 
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
endif

filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" }}}
" Plugins {{{

Plugin 'EasyGrep'
Plugin 'Gundo'
Plugin 'Tabular'
Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
Plugin 'UltiSnips'
Plugin 'abolish.vim'
Plugin 'acx0/Conque-Shell'
Plugin 'altercation/vim-colors-solarized'
Plugin 'camelcasemotion'
Plugin 'ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'fugitive.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'honza/vim-snippets'
Plugin 'hsanson/vim-android'
Plugin 'lervag/vimtex'
Plugin 'majutsushi/tagbar'
Plugin 'matze/vim-tex-fold'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'rizzatti/dash.vim'
Plugin 'rizzatti/funcoo.vim'
Plugin 'scratch.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'syntastic'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'udalov/kotlin-vim'
Plugin 'unimpaired.vim'
Plugin 'vim-multiple-cursors'


call vundle#end()
filetype plugin indent on

" }}}
" Theme {{{

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set gfn=Source\ Code\ Pro:h14
set background=dark
colorscheme solarized

set ts=4
set sw=4

" }}}
" Window Setup {{{

syntax enable
syntax on

set nocompatible
set autoindent
set smartindent
set scrolloff=5
set shiftwidth=4
set showmatch
set guioptions-=T
set ruler
set nowrap
set number
set smarttab
set expandtab
set softtabstop=4
set laststatus=2

filetype on
filetype plugin on

set backspace=indent,eol,start

let python_highlight_all = 1
let java_highlight_all = 1


" }}}
" Functions {{{
function! WriteBufferIfNecessary()
  if &modified && !&readonly
    :write
  endif
endfunction
command! WriteBufferIfNecessary call WriteBufferIfNecessary()

function! PresentationModeOn()
  colorscheme github

  if has("gui_macvim")
    set guifont=Monaco:h25           " for Mac
  elseif has("gui_gtk")
    set guifont=Monospace\ 22        " for ubuntu
  end
endfunction

function! PresentationModeOff()
  colorscheme rails_envy

  if has("gui_macvim")
    set guifont=Monaco:h17           " for Mac
  elseif has("gui_gtk")
    set guifont=Monospace\ 14        " for ubuntu
  end
endfunction

function! TogglePresentationMode()
  if !exists('w:present')
    let w:present=0
  endif

  if w:present==0
    call PresentationModeOn()
    let w:present=1
  else
    call PresentationModeOff()
    let w:present=0
  endif
endfunction

"}}}
" Key Setup {{{

nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

nmap <silent> <c-Tab> :tabn<CR>
nmap <silent> <c-S-Tab> :tabp<CR>

nmap <silent> <leader>"p vi""+p
nmap <silent> <leader>(p vi("+p

nmap <silent> <F1> :NERDTreeToggle<CR>
nmap <silent> <F2> :setlocal spell! spelllang=en_us<CR>
nmap <silent> <F3> :GundoToggle<CR>
nmap <silent> <F11> :call TogglePresentationMode()<CR>
nmap <silent> <C-F3> :GundoRenderGraph<CR>
nmap <silent> <leader>l :TagbarToggle<CR>

" }}}
" NERDTree SEtup {{{

let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$']
let NERDTreeChDirMode = 2

" }}}
" Ctrl-P Fuzzy Finder {{{

set wildignore+=\.git                  "" General Files
set wildignore+=\bin,\gen,\docs,\build "" Android Files
set wildignore+=\south,\piston         "" Django File
set wildignore+=\node_modules          "" Node Files
set wildignore+=*.swp,*.swo            "" VIM Files
set wildignore+=*.png,*.jpg            "" Binary Files
set wildignore+=*.jar,*.class          "" Java Files

" }}}
" Plugin Setup {{{

let g:github_user='wmbest2@gmail.com'
let g:github_token='bbef7885ea5ad08291e0f72ba194864c'

let g:gofmt_command = "/usr/local/go/bin/gofmt"

" }}}
" Filetype Specific Settings {{{ 

au BufRead *.html set filetype=htmldjango
au BufWritePre,FileWritePre *.java :retab
au BufWritePre,FileWritePre *.py :retab
au BufWritePre,FileWritePre *.js :retab

au BufRead,BufWritePre,FileWritePre *.go set filetype=go
au FileType java set expandtab
au FileType java set makeprg=ant\ debug
au FileType java set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
au FileType modula2 set filetype=markdown
au FileType javascript map <Leader>j !python -m json.tool<CR>
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

if has("autocmd") 
    let g:android_sdk_path = $ANDROID_HOME
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete 
    autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
endif 

" }}}
" Helpers {{{
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.
" }}}
