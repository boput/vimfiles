vim9script

if $XDG_SESSION_TYPE != 'wayland'
    finish
endif

def WLYank(event: dict<any>)
    if event.regname =~ '[+*]'
        system('wl-copy', getreg("@"))
    endif
enddef


def WLPaste()
    setreg("@", system('wl-paste --no-newline')->substitute('
enddef


augroup WLYank | au!
    au TextYankPost * call WLYank(v:event)
augroup END


xnoremap "+p <ScriptCmd>WLPaste()<CR>p
xnoremap "+P <ScriptCmd>WLPaste()<CR>P
xnoremap "*p <ScriptCmd>WLPaste()<CR>p
xnoremap "*P <ScriptCmd>WLPaste()<CR>P
nnoremap "+p <ScriptCmd>WLPaste()<CR>p
nnoremap "+P <ScriptCmd>WLPaste()<CR>P
nnoremap "*p <ScriptCmd>WLPaste()<CR>p
nnoremap "*P <ScriptCmd>WLPaste()<CR>P

inoremap <C-r>+ <ScriptCmd>WLPaste()<CR><C-r>"
inoremap <C-r>* <ScriptCmd>WLPaste()<CR><C-r>"