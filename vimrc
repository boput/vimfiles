vim9script

# boput changes ======
if &compatible | set nocompatible | endif
silent! while 0
  set nocompatible silent!
endwhile

language en_US.UTF8
set langmenu=en_US
$LANG = 'en_US'

set encoding=utf-8 fileencoding=utf-8 fileformats=unix,dos
scriptencoding utf-8

# vint: -ProhibitAutocmdWithNoGroup
exe 'augroup vimrc'
autocmd!

const is_win = has('win32')
$v = $HOME .. (is_win ? '\vimfiles' : '/.vim')
$VIMRC = $v .. '/vimrc'

def Source(file: string)
  execute $'source $v/{file}.vim'
enddef

setglobal pastetoggle=<F2>
# =====

# habamax
set hidden confirm
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set ttimeout ttimeoutlen=25
set ruler
set belloff=all shortmess+=Ic
set display=lastline smoothscroll
set hlsearch incsearch ignorecase smartcase
set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags
set completeopt=menu,popup,fuzzy completepopup=highlight:Pmenu
set number relativenumber cursorline cursorlineopt=number signcolumn=number
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=fold:\ ,vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set fileformat=unix fileformats=unix,dos
set sidescroll=1 sidescrolloff=3
set nrformats=bin,hex,unsigned
set nospell spelllang=en,ru
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set sessionoptions=buffers,curdir,tabpages,winsize
set viminfo='200,<500,s32
set mouse=a

if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

&directory = $'{$MYVIMDIR}/.data/swap/'
&backupdir = $'{$MYVIMDIR}/.data/backup//'
&undodir = $'{$MYVIMDIR}/.data/undo//'
&viminfofile = $'{$MYVIMDIR}/.data/info/viminfo'
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile

# boput changes =====
# Not needed packages
Source('local')

# Load plugins
Source('pack/packs')

# vint: -ProhibitAutocmdWithNoGroup
exe 'augroup END'
