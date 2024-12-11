vim9script

set winaltkeys=no
set guioptions=cM!

if has("win32")
    set linespace=0

    # set guifont=Iosevka_Habamax:h17,:h17
    set guifont=Iosevka_Fixed_SS06:h14,:h14


    # :h w32-experimental-keycode-trans-strategy
    # Should fix CTRL-=
    augroup mswin_strat | au!
        au VimEnter * test_mswin_event('set_keycode_trans_strategy', {'strategy': 'experimental'})
    augroup END
else
    set guifont=Monospace\ 19
endif

# quick font check:
# З3Э -- cyrillic ze, three, cyrillic e
# 1lI0OQB8 =-+*:(){}[]
# I1legal
