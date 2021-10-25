" Vim reST syntax file
" Language: reStructuredText syntax file
" Maintainer: Maxim Kim <habamax@gmail.com>
" Description: Based on https://github.com/marshallward/vim-restructuredtext

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match rstTransition /^[=`:.'"~^_*+#-]\{4,}\s*$/


" TODO: rename to rstInline
syn cluster rstCruft contains=rstEmphasis,rstStrongEmphasis,
      \ rstInterpretedText,rstInlineLiteral,rstSubstitutionReference,
      \ rstInlineInternalTargets,rstFootnoteReference,rstHyperlinkReference

syn region rstLiteralBlock matchgroup=rstDelimiter
      \ start='\(^\z(\s*\).*\)\@<=::\n\s*\n' skip='^\s*$' end='^\(\z1\s\+\)\@!'
      \ contains=@NoSpell

syn region rstQuotedLiteralBlock matchgroup=rstDelimiter
      \ start="::\_s*\n\ze\z([!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]\)"
      \ end='^\z1\@!' contains=@NoSpell

syn region rstDoctestBlock oneline display matchgroup=rstDelimiter
      \ start='^>>>\s' end='^$'

syn region rstTable transparent start='^\n\s*+[-=+]\+' end='^$'
      \ contains=rstTableLines,@rstCruft
syn match rstTableLines contained display '|\|+\%(=\+\|-\+\)\='

syn region rstSimpleTable transparent
      \ start='^\n\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
      \ end='^$'
      \ contains=rstSimpleTableLines,@rstCruft
syn match rstSimpleTableLines contained display
      \ '^\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
syn match rstSimpleTableLines contained display
      \ '^\%(\s*\)\@>\%(\%(-\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(-\+\)\@>\%(\s*\)\@>\)\+\)\@>$'

syn cluster rstDirectives contains=rstFootnote,rstCitation,
      \ rstHyperlinkTarget,rstExDirective

syn match rstExplicitMarkup '^\s*\.\.\_s'
      \ nextgroup=@rstDirectives,rstComment,rstSubstitutionDefinition

" TODO: check if unicode is allowed...
" Simple reference names are single words consisting of alphanumerics plus
" isolated (no two adjacent) internal hyphens, underscores, periods, colons
" and plus signs.
let s:ref_name = '[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*'

syn keyword rstTodo contained FIXME TODO XXX NOTE

execute 'syn region rstComment contained' .
      \ ' start=/.*/'
      \ ' skip=+^$+' .
      \ ' end=/^\s\@!/ contains=rstTodo'

execute 'syn region rstFootnote contained matchgroup=rstDirective' .
      \ ' start=+\[\%(\d\+\|#\%(' . s:ref_name . '\)\=\|\*\)\]\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,@NoSpell'

execute 'syn region rstCitation contained matchgroup=rstDirective' .
      \ ' start=+\[' . s:ref_name . '\]\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,@NoSpell'

syn region rstHyperlinkTarget contained matchgroup=rstDirective
      \ start='_\%(_\|[^:\\]*\%(\\.[^:\\]*\)*\):\_s' skip=+^$+ end=+^\s\@!+

syn region rstHyperlinkTarget contained matchgroup=rstDirective
      \ start='_`[^`\\]*\%(\\.[^`\\]*\)*`:\_s' skip=+^$+ end=+^\s\@!+

syn region rstHyperlinkTarget matchgroup=rstDirective
      \ start=+^__\_s+ skip=+^$+ end=+^\s\@!+

execute 'syn region rstExDirective contained matchgroup=rstDirective' .
      \ ' start=+' . s:ref_name . '::\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,rstLiteralBlock'

syn match rstSubstitutionDefinition contained /|.*|\_s\+/ nextgroup=@rstDirectives

" Inline markup recognition rules
" https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#inline-markup
let s:inline_start = '<(\[{"'."'"
let s:inline_end = ')\]}>"'."'"

syn region rstInterpretedText matchgroup=rstDelimiter
      \ start=+\(^\|[[:space:]-:/]\)\zs`\ze[^`[:space:]]+
      \ skip=+\\`+
      \ end=+\S\zs`\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstInlineLiteral matchgroup=rstDelimiter
      \ start=+\(^\|[[:space:]-:/]\)\zs``\ze\S+
      \ end=+\S\zs``\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstEmphasis matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs\*\ze[^*[:space:]]+
      \ skip=+\\\*+
      \ end=+\S\zs\*\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstStrongEmphasis matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs\*\*\ze[^[:space:]]+
      \ skip=+\\\*+
      \ end=+\S\zs\*\*\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

for ch in [['(', ')'], ['{', '}'], ['<', '>'], ['\[', '\]'], ['"', '"'], ["'", "'"]]
    execute 'syn region rstEmphasis matchgroup=rstDelimiter' .
          \ ' start=+'.ch[0].'\zs\*\ze[^*[:space:]'.ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs\*\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstStrongEmphasis matchgroup=rstDelimiter' .
          \ ' start=+'.ch[0].'\zs\*\*\ze[^[:space:]'.ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs\*\*\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstInterpretedText matchgroup=rstDelimiter' .
          \ ' start=+'.ch[0].'\zs`\ze[^`[:space:]'.ch[1].']+' .
          \ ' skip=+\\`+' .
          \ ' end=+\S\zs`\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstInlineLiteral matchgroup=rstDelimiter' .
          \ ' start=+'.ch[0].'\zs``\ze[^[:space:]'.ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs``\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
endfor



" function! s:DefineOneInlineMarkup(name, start, middle, end, char_left, char_right)
"   " Only escape the first char of a multichar delimiter (e.g. \* inside **)
"   if a:start[0] == '\'
"     let first = a:start[0:1]
"   else
"     let first = a:start[0]
"   endif

"   execute 'syn match rstEscape'.a:name.' +\\\\\|\\'.first.'+'.' contained'

"   execute 'syn region rst' . a:name .
"         \ ' start=+' . a:char_left . '\zs' . a:start .
"         \ '\ze[^[:space:]' . a:char_right . a:start[strlen(a:start) - 1] . ']+' .
"         \ a:middle .
"         \ ' end=+' . a:end . '\ze\%($\|\s\|[''"’)\]}>/:.,;!?\\-]\)+' .
"         \ ' contains=rstEscape' . a:name

"   execute 'hi def link rstEscape'.a:name.' Special'
" endfunction

" function! s:DefineInlineMarkup(name, start, middle, end)
"     let middle = a:middle != "" ?
"           \ (' skip=+\\\\\|\\' . a:middle . '\|\s' . a:middle . '+') :
"           \ ""

"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, "'", "'")
"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '"', '"')
"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '(', ')')
"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '\[', '\]')
"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '{', '}')
"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '<', '>')
"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '’', '’')
"     " TODO: Additional Unicode Pd, Po, Pi, Pf, Ps characters

"     call s:DefineOneInlineMarkup(a:name, a:start, middle, a:end, '\%(^\|\s\|\%ua0\|[/:]\)', '')

"     execute 'syn match rst' . a:name .
"           \ ' +\%(^\|\s\|\%ua0\|[''"([{</:]\)\zs' . a:start .
"           \ '[^[:space:]' . a:start[strlen(a:start) - 1] . ']'
"           \ a:end . '\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)+'

"     execute 'hi def link rst' . a:name . 'Delimiter' . ' rst' . a:name
" endfunction

" call s:DefineInlineMarkup('Emphasis', '\*', '\*', '\*')
" call s:DefineInlineMarkup('StrongEmphasis', '\*\*', '\*', '\*\*')
" call s:DefineInlineMarkup('InterpretedTextOrHyperlinkReference', '`', '`', '`_\{0,2}')
" call s:DefineInlineMarkup('InlineLiteral', '``', "", '``')
" call s:DefineInlineMarkup('SubstitutionReference', '|', '|', '|_\{0,2}')
" call s:DefineInlineMarkup('InlineInternalTargets', '_`', '`', '`')

syn match rstSectionDelimiter contained "\v^([=`:.'"~^_*+#-])\1+\s*$"
syn match rstSection "\v^%(([=`:.'"~^_*+#-])\1+\n)?.{1,2}\n([=`:.'"~^_*+#-])\2+$"
      \ contains=rstSectionDelimiter,@Spell
syn match rstSection "\v^%(([=`:.'"~^_*+#-])\1{2,}\n)?.{3,}\n([=`:.'"~^_*+#-])\2{2,}$"
      \ contains=rstSectionDelimiter,@Spell

" TODO: Can’t remember why these two can’t be defined like the ones above.
execute 'syn match rstFootnoteReference contains=@NoSpell' .
      \ ' +\%(\s\|^\)\[\%(\d\+\|#\%(' . s:ref_name . '\)\=\|\*\)\]_+'

execute 'syn match rstCitationReference contains=@NoSpell' .
      \ ' +\%(\s\|^\)\[' . s:ref_name . '\]_\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)+'

execute 'syn match rstHyperlinkReference' .
      \ ' /\<' . s:ref_name . '__\=\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)/'

syn match rstStandaloneHyperlink contains=@NoSpell
      \ "\<\%(\%(\%(https\=\|file\|ftp\|gopher\)://\|\%(mailto\|news\):\)[^[:space:]'\"<>]\+\|www[[:alnum:]_-]*\.[[:alnum:]_-]\+\.[^[:space:]'\"<>]\+\)[[:alnum:]/]"

syn region rstCodeBlock contained matchgroup=rstDirective
      \ start=+\%(sourcecode\|code\%(-block\)\=\)::\s*\(\S*\)\?\s*\n\%(\s*:.*:\s*.*\s*\n\)*\n\ze\z(\s\+\)+
      \ skip=+^$+
      \ end=+^\z1\@!+
      \ contains=@NoSpell
syn cluster rstDirectives add=rstCodeBlock

if !exists('g:rst_syntax_code_list')
    " A mapping from a Vim filetype to a list of alias patterns (pattern
    " branches to be specific, see ':help /pattern'). E.g. given:
    "
    "   let g:rst_syntax_code_list = {
    "       \ 'cpp': ['cpp', 'c++'],
    "       \ }
    "
    " then the respective contents of the following two rST directives:
    "
    "   .. code:: cpp
    "
    "       auto i = 42;
    "
    "   .. code:: C++
    "
    "       auto i = 42;
    "
    " will both be highlighted as C++ code. As shown by the latter block
    " pattern matching will be case-insensitive.
    let g:rst_syntax_code_list = {
        \ 'vim': ['vim'],
        \ 'java': ['java'],
        \ 'cpp': ['cpp', 'c++'],
        \ 'lisp': ['lisp'],
        \ 'php': ['php'],
        \ 'python': ['python'],
        \ 'perl': ['perl'],
        \ 'sh': ['sh'],
        \ }
elseif type(g:rst_syntax_code_list) == type([])
    " backward compatibility with former list format
    let s:old_spec = g:rst_syntax_code_list
    let g:rst_syntax_code_list = {}
    for s:elem in s:old_spec
        let g:rst_syntax_code_list[s:elem] = [s:elem]
    endfor
endif

for s:filetype in keys(g:rst_syntax_code_list)
    unlet! b:current_syntax
    " guard against setting 'isk' option which might cause problems (issue #108)
    let prior_isk = &l:iskeyword
    let s:alias_pattern = ''
          \. '\%('
          \. join(g:rst_syntax_code_list[s:filetype], '\|')
          \. '\)'

    exe 'syn include @rst'.s:filetype.' syntax/'.s:filetype.'.vim'
    exe 'syn region rstDirective'.s:filetype
          \. ' matchgroup=rstDirective fold'
          \. ' start="\c\%(sourcecode\|code\%(-block\)\=\)::\s\+'.s:alias_pattern.'\_s*\n\ze\z(\s\+\)"'
          \. ' skip=#^$#'
          \. ' end=#^\z1\@!#'
          \. ' contains=@NoSpell,@rst'.s:filetype
    exe 'syn cluster rstDirectives add=rstDirective'.s:filetype

    " reset 'isk' setting, if it has been changed
    if &l:iskeyword !=# prior_isk
        let &l:iskeyword = prior_isk
    endif
    unlet! prior_isk
endfor

" Enable top level spell checking
syntax spell toplevel

" TODO: Use better syncing.
syn sync minlines=50 linebreaks=2

hi def link rstTodo                         Todo
hi def link rstComment                      Comment
hi def link rstSection                      Title
hi def link rstSectionDelimiter             Type
hi def link rstTransition                   Delimiter
hi def link rstLiteralBlock                 String
hi def link rstQuotedLiteralBlock           String
hi def link rstDoctestBlock                 PreProc
hi def link rstTableLines                   rstDelimiter
hi def link rstSimpleTableLines             rstTableLines
hi def link rstExplicitMarkup               rstDirective
hi def link rstDirective                    Keyword
hi def link rstFootnote                     String
hi def link rstCitation                     String
hi def link rstHyperlinkTarget              String
hi def link rstExDirective                  String
hi def link rstSubstitutionDefinition       rstDirective
hi def link rstDelimiter                    Delimiter
hi def link rstInterpretedText              Identifier
hi def link rstInlineLiteral                String
hi def link rstSubstitutionReference        PreProc
hi def link rstInlineInternalTargets        Identifier
hi def link rstFootnoteReference            Identifier
hi def link rstCitationReference            Identifier
hi def link rstHyperLinkReference           Identifier
hi def link rstStandaloneHyperlink          Identifier
hi def link rstCodeBlock                    String
hi def rstEmphasis          term=italic cterm=italic gui=italic
hi def rstStrongEmphasis    term=bold cterm=bold gui=bold

let b:current_syntax = "rst"

let &cpo = s:cpo_save
unlet s:cpo_save

