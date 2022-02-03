set nocompatible
set encoding=utf-8

""" Terminal colors and escape sequences
" 256 colors
set t_Co=256
" Color escape
set t_AF=[38;5;%dm
set t_AB=[48;5;%dm
" Italic escape
set t_ZH=[3m
set t_ZR=[23m

""" Interface configuration
" Line numbering
set number
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu | endif
autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END
" Cursor configuration
set cursorline

""" Visible characters and text formatting
" Visible symbols
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:⎵,trail:·,eol:¬
set list
set showbreak=↪
set breakindent
set breakindentopt=shift:-1
" Tabs and spaces
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
" Text wrapping
set textwidth=79
set backspace=indent,eol,start
let &colorcolumn="80"

""" Color schemes and sytax
syntax enable
let g:solarized_termcolors=256
let g:solarized_italic=1
let g:solarized_bold=1
let g:solarized_underline=1
colorscheme solarized
set background=dark
set hlsearch
" Airline configuration
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'
set noshowmode
" Airline customization
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_symbols.maxlinenr=' ≡ '
let g:airline_symbols.branch='⎇'
let g:airline_symbols.linenr=' '
let g:airline_symbols.colnr=''
let g:airline_symbols.dirty=''
let g:airline_symbols.notexists=''
let g:airline_symbols.whitespace=''
" Airline extensions
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#fnamemod=':t'
"let g:airline#extensions#tabline#tab_min_count=2
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
" Gitgutter
set signcolumn=auto
set updatetime=100
hi! link SignColumn LineNr
let g:gitgutter_set_sign_backgrounds=1
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='│'
let g:gitgutter_sign_removed='_'
let g:gitgutter_sign_removed_first_line='‾'

""" Controls
" Mouse events support
set mouse=a

