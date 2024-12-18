vim9script

# vint: -ProhibitAutocmdWithNoGroup; end of augroup at the end of each file
exe 'augroup au_packs'
autocmd!

# Install k-takata minmpac if does not exist.
const minpac_dir = $v .. '/pack/minpac/opt/minpac'
if !isdirectory(minpac_dir)
  echo 'Installing minpac...'
  echo ''
  silent! execute printf('!git clone https://github.com//minpac.git %s', minpac_dir)
endif
# Install bennyyip plugpac if does not exist.
if !filereadable(expand('$MYVIMDIR/autoload/plugpac.vim'))
  echo 'Installing plugpac...'
  echo ''
  silent !\curl -fLo .\vimfiles\autoload\plugac.vim --create-dirs https://raw.githubusercontent.com/bennyyip/plugpac.vim/master/plugpac.vim
endif

g:plugpac_plugin_conf_path = $v .. '/rc'
g:plugpac_default_type = 'delay'

# minpac must have {'type': 'opt'} so that it can be loaded with `packadd`
packadd minpac

# plugins manually added
packadd comment


call plugpac#Begin({
  # progress_open: tab',
  status_open: 'vertical',
  verbose: 2,
})

# -------------------------------------
# minpac
Pack 'k-takata/minpac', {'type': 'opt'}
# -------------------------------------
# Pack 'junegunn/vim-easy-align'
# Pack 'tommcdo/vim-lion', {'type': 'start'}

Pack 'tpope/vim-fugitive'
Pack 'tpope/vim-abolish'
# Pack 'tpope/vim-endwise'
# Pack 'tpope/vim-characterize'
# Pack 'tpope/vim-repeat'
# Pack 'tpope/vim-rsi'
Pack 'tpope/vim-scriptease'
Pack 'tpope/vim-sensible', {'type': 'start'}
# Pack 'tpope/vim-surround', {'type': 'delay'}
# Pack 'tpope/vim-unimpaired'

Pack 'machakann/vim-sandwich' # vim-sandwich, mimic vim-surround mappings

# Pack 'chrisbra/unicode.vim'

# Pack 'justinmk/vim-sneak', {'type': 'start'}

Pack 'boput/vim-popot', {'for': ['po, pot']}

Pack 'habamax/vim-dir'
Pack 'habamax/vim-gruvbit'
Pack 'habamax/vim-nod'

Pack 'romainl/vim-qf'

# Pack 'girishji/autosuggest.vim'
# Need this autocmd to supress message from VimCompleteLoaded
Pack 'girishji/vimcomplete', {'type': 'start'}
# Pack 'girishji/ngram-complete.vim', {'type': 'start'}
Pack 'girishji/declutter.vim'
# Pack 'girishji/easyjump.vim'
# Pack 'girishji/fFtT.vim'

Pack 'rose-pine/vim'

Pack 'ryanoasis/vim-devicons'
# --------------------------------------
plugpac#End()
# --------------------------------------

# plugpac helpers
def PackList(A: string, ...args: list<any>): list<string>
  plugpac#Init()
  const pluglist = minpac#getpluglist()->keys()->sort()
  return pluglist->Utils.Matchfuzzy(A)
enddef

command! -nargs=1 -complete=customlist,PackList
  \ PackUrl call plugpac#Init() | call openbrowser#open(
  \    minpac#getpluginfo(<q-args>).url)

command! -nargs=1 -complete=customlist,PackList
  \ PackDir call plugpac#Init() | execute 'edit ' .. minpac#getpluginfo(<q-args>).dir

command! -nargs=1 -complete=customlist,PackList
  \ PackRc call plugpac#Init() | execute 'edit ' ..
  \ g:plugpac_plugin_conf_path .. '/' ..
  \ substitute(minpac#getpluginfo(<q-args>).name, '\.n\?vim$', '', '') .. '.vim'

command! -nargs=1 -complete=customlist,PackList
  \ PackRcPre call plugpac#Init() | execute 'edit ' ..
  \ g:plugpac_plugin_conf_path .. '/pre-' ..
  \ substitute(minpac#getpluginfo(<q-args>).name, '\.n\?vim$', '', '') .. '.vim'


# vint: -ProhibitAutocmdWithNoGroup
exe 'augroup END'
