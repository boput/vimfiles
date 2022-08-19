vim9script
finish

def InlineColors(clear: bool = false): void
    var view = winsaveview()
    var line_start = view.topline
    var line_end = view.topline + winheight(winnr())

    if exists('b:inline_color_ids')
        map(b:inline_color_ids, (_, p) => prop_remove({id: p}, line_start, line_end))
        unlet b:inline_color_ids
    endif
    b:inline_color_ids = []
    if clear | return | endif


    for linenr in range(line_start, line_end)
        var current = getline(linenr)
        var cnt = 1
        var [hex, starts, ends] = matchstrpos(current, '#\x\{6\}', 0, cnt)
        while starts != -1
            var col_tag = "inline_color_" .. hex[1 : ]
            var col_type = prop_type_get(col_tag)
            var hl = hlget(col_tag)
            if empty(hl) || hl[0]->has_key("cleared")
                hlset([{name: col_tag, guifg: hex}])
            endif
            if col_type == {}
                prop_type_add(col_tag, {highlight: col_tag})
            endif
            b:inline_color_ids->add(prop_add(linenr, starts + 1, {length: ends - starts, text: " \u25CF ", type: col_tag}))
            cnt += 1
            [hex, starts, ends] = matchstrpos(current, '#\x\{6\}', 0, cnt)
        endwhile
    endfor
enddef

augroup group_name | au!
    au WinScrolled * InlineColors()
    au BufEnter * InlineColors()
    au OptionSet background InlineColors()
    au Colorscheme * InlineColors()
augroup END

finish
        0 #000000 black                    8  #7f7f7f darkgrey
        1 #cd0000 darkred                  9  #ff0000 red
        2 #00cd00 darkgreen                10 #00ff00 green
        3 #cdcd00 darkyellow               11 #ffff00 yellow
        4 #0000ee darkblue                 12 #5c5cff blue
        5 #cd00cd darkmagenta              13 #ff00ff magenta
        6 #00cdcd darkcyan                 14 #00ffff cyan
        7 #e5e5e5 grey                     15 #ffffff white


        16 #000000              88  #870000             160 #d70000
        17 #00005f              89  #87005f             161 #d7005f
        18 #000087              90  #870087             162 #d70087
        19 #0000af              91  #8700af             163 #d700af
        20 #0000d7              92  #8700d7             164 #d700d7
        21 #0000ff              93  #8700ff             165 #d700ff
        22 #005f00              94  #875f00             166 #d75f00
        23 #005f5f              95  #875f5f             167 #d75f5f
        24 #005f87              96  #875f87             168 #d75f87
        25 #005faf              97  #875faf             169 #d75faf
        26 #005fd7              98  #875fd7             170 #d75fd7
        27 #005fff              99  #875fff             171 #d75fff
        28 #008700              100 #878700             172 #d78700
        29 #00875f              101 #87875f             173 #d7875f
        30 #008787              102 #878787             174 #d78787
        31 #0087af              103 #8787af             175 #d787af
        32 #0087d7              104 #8787d7             176 #d787d7
        33 #0087ff              105 #8787ff             177 #d787ff
        34 #00af00              106 #87af00             178 #d7af00
        35 #00af5f              107 #87af5f             179 #d7af5f
        36 #00af87              108 #87af87             180 #d7af87
        37 #00afaf              109 #87afaf             181 #d7afaf
        38 #00afd7              110 #87afd7             182 #d7afd7
        39 #00afff              111 #87afff             183 #d7afff
        40 #00d700              112 #87d700             184 #d7d700
        41 #00d75f              113 #87d75f             185 #d7d75f
        42 #00d787              114 #87d787             186 #d7d787
        43 #00d7af              115 #87d7af             187 #d7d7af
        44 #00d7d7              116 #87d7d7             188 #d7d7d7
        45 #00d7ff              117 #87d7ff             189 #d7d7ff
        46 #00ff00              118 #87ff00             190 #d7ff00
        47 #00ff5f              119 #87ff5f             191 #d7ff5f
        48 #00ff87              120 #87ff87             192 #d7ff87
        49 #00ffaf              121 #87ffaf             193 #d7ffaf
        50 #00ffd7              122 #87ffd7             194 #d7ffd7
        51 #00ffff              123 #87ffff             195 #d7ffff
        52 #5f0000              124 #af0000             196 #ff0000
        53 #5f005f              125 #af005f             197 #ff005f
        54 #5f0087              126 #af0087             198 #ff0087
        55 #5f00af              127 #af00af             199 #ff00af
        56 #5f00d7              128 #af00d7             200 #ff00d7
        57 #5f00ff              129 #af00ff             201 #ff00ff
        58 #5f5f00              130 #af5f00             202 #ff5f00
        59 #5f5f5f              131 #af5f5f             203 #ff5f5f
        60 #5f5f87              132 #af5f87             204 #ff5f87
        61 #5f5faf              133 #af5faf             205 #ff5faf
        62 #5f5fd7              134 #af5fd7             206 #ff5fd7
        63 #5f5fff              135 #af5fff             207 #ff5fff
        64 #5f8700              136 #af8700             208 #ff8700
        65 #5f875f              137 #af875f             209 #ff875f
        66 #5f8787              138 #af8787             210 #ff8787
        67 #5f87af              139 #af87af             211 #ff87af
        68 #5f87d7              140 #af87d7             212 #ff87d7
        69 #5f87ff              141 #af87ff             213 #ff87ff
        70 #5faf00              142 #afaf00             214 #ffaf00
        71 #5faf5f              143 #afaf5f             215 #ffaf5f
        72 #5faf87              144 #afaf87             216 #ffaf87
        73 #5fafaf              145 #afafaf             217 #ffafaf
        74 #5fafd7              146 #afafd7             218 #ffafd7
        75 #5fafff              147 #afafff             219 #ffafff
        76 #5fd700              148 #afd700             220 #ffd700
        77 #5fd75f              149 #afd75f             221 #ffd75f
        78 #5fd787              150 #afd787             222 #ffd787
        79 #5fd7af              151 #afd7af             223 #ffd7af
        80 #5fd7d7              152 #afd7d7             224 #ffd7d7
        81 #5fd7ff              153 #afd7ff             225 #ffd7ff
        82 #5fff00              154 #afff00             226 #ffff00
        83 #5fff5f              155 #afff5f             227 #ffff5f
        84 #5fff87              156 #afff87             228 #ffff87
        85 #5fffaf              157 #afffaf             229 #ffffaf
        86 #5fffd7              158 #afffd7             230 #ffffd7
        87 #5fffff              159 #afffff             231 #ffffff

        232 #080808                244 #808080
        233 #121212                245 #8a8a8a
        234 #1c1c1c                246 #949494
        235 #262626                247 #9e9e9e
        236 #303030                248 #a8a8a8
        237 #3a3a3a                249 #b2b2b2
        238 #444444                250 #bcbcbc
        239 #4e4e4e                251 #c6c6c6
        240 #585858                252 #d0d0d0
        241 #626262                253 #dadada
        242 #6c6c6c                254 #e4e4e4
        243 #767676                255 #eeeeee