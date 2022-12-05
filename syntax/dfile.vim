" Brocade dfile syntax file
" Language:   Brocade dfiles
" Maintainer: Tom Deneire, tomdeneire@gmail.com
" Last change: 28 November 2022

syn clear
syn sync    maxlines=0
syn sync    minlines=0
syn case    ignore

" Regions
syn region    comment       start=/\/\// end=/\n/
syn region    macrocodeline    oneline start="^macro" end=/\:/ contains=macrocodelabel,macrocode,macroargs
syn region    macroargs     oneline start="(" end=")" contains=operator,macroarg
syn region    macroline        start=/    / keepend end=/$/ contains=macrosynopsis,macroexample,macroparam,operator,macrostartend,macroinstruction,macrostring
syn region    macrostring oneline start=/"/ end=/"/
syn region    macroinstruction contained start="    «" end="»$"

" Matches
syn match     macrostartend    contained "'''"
syn match     macrocodelabel   contained /^macro/
syn match     macrocode        contained / [A-Za-z0-9]*/
syn match     macrosynopsis    contained "\$synopsis:" contains=operator
syn match     macroexample     contained "\$example:" contains=operator
syn match     macroparam       contained /\$[A-Za-z0-9]*:/ contains=operator,macrosynopsis,macroexample
syn match     macroarg         contained /\$[A-Za-z0-9]*/
syn match     operator         contained "[«»\(\):]"

" The default methods for highlighting.  Can be overridden later
hi! link macrocodelabel      DfileMacroLabel
hi! link macrocode           MumpsLabelName
hi! link macroarg            Keyword
hi! link macrosynopsis       DfileSpecial
hi! link macroexample        DfileSpecial
hi! link macroparam          Keyword
hi! link macroinstruction    DfileInstruction
hi! link comment             Comment
hi! link operator            Operator
hi! link macrostring         String

let b:current_syntax = "dfile"
