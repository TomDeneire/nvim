" Brocade lfile syntax file
" Language:   Brocade lfiles
" Maintainer: Tom Deneire, tomdeneire@gmail.com
" Last change: 25 November 2022

syn clear
syn sync    maxlines=0
syn sync    minlines=0
syn case    ignore

" Regions
syn region    comment       start=/\/\// end=/\n/
syn region    lgcodeline    oneline start=/lgcode/ end=/\:/ contains=lgcodelabel,lgcode
syn region    lgline        start=/    / keepend end=/$/ contains=lglabel,operator

" Matches
syn match     lgcodelabel   contained /lgcode/
syn match     lgcode        contained / [A-Za-z0-9_-]*/
syn match     lgcode        contained / [A-Za-z0-9_-]*\.[A-Za-z0-9_-]*/
syn match     lgcode        contained / [A-Za-z0-9_-]*\.[A-Za-z0-9_-]*\.scope/
syn match     lglabel       contained /\CN\:/ contains=lg
syn match     lglabel       contained /\CE\:/ contains=lg
syn match     lglabel       contained /\CD\:/ contains=lg
syn match     lglabel       contained /\CU\:/ contains=lg
syn match     lglabel       contained /\CF\:/ contains=lg
syn match     lg            contained /\CN/
syn match     lg            contained /\CE/
syn match     lg            contained /\CF/
syn match     lg            contained /\CD/
syn match     lg            contained /\CU/
syn match     operator      contained "[«»]"

" The default methods for hilighting.  Can be overridden later
hi! link lgcodelabel      MumpsLabel
hi! link lgcode           MumpsLabelName
hi! link lg               Operator
hi! link comment          Comment
hi! link operator         Operator

let b:current_syntax = "lfile"


