vim9script

# Plugin: vim-scripts/po.vim--gray

# vint: -ProhibitAutocmdWithNoGroup
augroup vimrc
  autocmd!
augroup END

# Some local settings for gettext files
setlocal textwidth=0
setlocal noautoindent

# Load po_pot and setup vim for editing gettext .po, .pot files
autocmd BufNewFile,BufRead *.po,*.pot setlocal filetype=po
if has('gui_running')
  autocmd FileType po,pot setlocal columns=120 colorcolumn=81,88
elseif has('vcon')
  autocmd FileType po,pot setlocal colorcolumn=81,88
endif

autocmd FileType po,pot packadd vim-popot
# autocmd FileType po,pot map <M-;> <Plug>Sneak_,

# Header meta data for this translator
g:po_translator = 'Božidar Putanec <bozidarp@yahoo.com>'
g:po_lang_team = 'Croatian <lokalizacija@linux.hr>'
g:po_language = 'hr'
# need to escape '/',  in order to get correct output
g:po_charset = 'text\/plain; charset=UTF-8'
# needed to escape '&' in addition to above
g:po_plural_form = 'nplurals=3; plural\=(n%10==1 \&\& n%100!=11 ? 0 : n%10>=2 \&\& n%10<=4 \&\& (n%100<10 || n%100>=20) ? 1 : 2);'
g:po_xgenerator = 'Vim'

