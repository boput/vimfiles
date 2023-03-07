vim9script


if executable('black')
    &l:formatprg = "black -q - 2>/dev/null"
elseif executable('yapf')
    # pip install yapf
    &l:formatprg = "yapf"
endif

setlocal foldignore=

b:undo_ftplugin ..= ' | setl foldignore< formatprg<'

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("python -m pydoc " .. symbol), (winid) => {
        setbufvar(winbufnr(winid), "&ft", "rst")
    })
enddef


nnoremap <buffer> <F5> <scriptcmd>Sh python %:p<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'


if exists("g:loaded_ale")
    nnoremap <silent><buffer> K <scriptcmd>ALEHover<CR>
    nnoremap <silent><buffer> gd <scriptcmd>ALEGoToDefinition<CR>
    nnoremap <silent><buffer> <space>ar <scriptcmd>ALEFindReferences<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>ar"'
else
    nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
    xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "xunmap <buffer> K"'
endif


def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)\(def\|class\) \k\+('
                || line =~ 'if __name__ == "__main__":'
            things->add({text: $"{line} ({nr})", linenr: nr})
        endif
    endfor
    popup.FilterMenu("Py Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            hi def link FilterMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
