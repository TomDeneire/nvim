" Brocade bfile syntax file
" Language:   Brocade bfiles
" Maintainer: Tom Deneire, tomdeneire@gmail.com
" Last change: 27 November 2022

syn clear
syn sync    maxlines=0
syn sync    minlines=0
syn case    ignore

" Regions
syn region    comment           start=/\/\// end=/\n/
syn region    objectcodeline    oneline start=/[a-z]/ end=/\:/ contains=objectcodelabel,objectcode
syn region    objectline        start=/    / keepend end=/$/ contains=objectlabel,operator

" Matches
syn match     objectcodelabel   contained /^oaiset/
syn match     objectcodelabel   contained /^oai/
syn match     objectcodelabel   contained /^mprocess/
syn match     objectcodelabel   contained /^mailtrg/
syn match     objectcodelabel   contained /^usergroup/
syn match     objectcodelabel   contained /^ujson/
syn match     objectcodelabel   contained /^lookup/
syn match     objectcodelabel   contained /^history/
syn match     objectcodelabel   contained /^meta/
syn match     objectcodelabel   contained /^listattribute/
syn match     objectcodelabel   contained /^listidentity/
syn match     objectcodelabel   contained /^listdownloadtype/
syn match     objectcodelabel   contained /^cg/
syn match     objectcodelabel   contained /^loi/
syn match     objectcodelabel   contained /^search/
syn match     objectcodelabel   contained /^listsorttype/
syn match     objectcodelabel   contained /^nodeattribute/
syn match     objectcodelabel   contained /^listconversion/
syn match     objectcode        contained / [A-Za-z0-9]*[\.]*[A-Za-z0-9]*/
syn match     objectlabel       contained /\$[$]*[A-Za-z0-9]*:/ contains=object,value
syn match     object            contained /\$[A-Za-z0-9]*/
syn match     value             contained /\$$[A-Za-z0-9]*/
syn match     operator          contained "[«»()]"

" The default methods for highlighting.  Can be overridden later
hi! link objectcodelabel  MumpsLabel
hi! link objectcode       MumpsLabelName
hi! link object           Constant
hi! link comment          Comment
hi! link operator         Operator
hi! link value            BfileValue

let b:current_syntax = "bfile"
