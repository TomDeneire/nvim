" Brocade .m syntax file
" Language:     Brocade .m files (MUMPS)
" Maintainer:   Tom Deneire, tomdeneire@gmail.com
" Last change:  25 November 2026

if exists('b:current_syntax')
    finish
endif

" Remove any old syntax stuff hanging around
syn clear

" MUMPS word characters
syntax iskeyword @,48-57,192-255

" Line Structure
syn region  mComment        oneline start="^//" end=/$/
syn region  mComment        oneline start=";" end=/$/ contained contains=mPragmaLine
" A label line holds nothing after the closing colon
syn region  mLabelLine      oneline start=/^\%(sub\|def\|fn\)\>/ end=/:$/ contains=mLabelCode,mLabelLabel,mLabelArgs,mLabelEnd
syn region  mString         oneline start=/"/ skip=/""/ end=/"/ contained
" keepend: nested items ending at end of line must not carry the line into the next one
syn region  mLine           oneline keepend start=/^\s/ end=/$/ contains=mString,mOperator,mComment,mCommand,mZcommand,mNumber,mFunction,mFunctionLabel,mMacroName,mMacroArgs,mPName,mUName,mFName,mCName,mRName,mGlobalName,mArgs,mDoGoArgs,mRegistry

" Matches
syn match   mRegistry       "r4\_[a-zA-Z0-9\_]*" contained
syn match   mLabelCode      /^\%(sub\|def\|fn\)\>/ contained
syn match   mLabelLabel     / [%A-Za-z0-9][A-Za-z0-9]*/ contained
syn match   mLabelArgs      /([%A-Za-z0-9][ ,%A-Za-z0-9]*)/ contained contains=mOperator,mPName,mUName,mFName,mCName,mRName
syn match   mOperator       "[-+,_*/=&#$!'\\[\]<>?@()«»:. ]" contained contains=mParentheses
syn match   mParentheses    "[()]" contained
" Commands: ISO abbreviations and full names in any case, followed by an argument, a postconditional or end of line
syn match   mCommand        /\c \%([bcdefghijklmnoqrsuvwx]\|break\|close\|do\|else\|for\|goto\|halt\|hang\|if\|job\|kill\|lock\|merge\|new\|open\|quit\|read\|set\|use\|view\|write\|xecute\)\%([ :]\|$\)/ contained contains=mOperator
syn match   mCommand        /\c \%(tr\|tc\|tro\|tre\|ts\|tcommit\|trestart\|trollback\|tstart\)\%( \|$\)/ contained contains=mOperator
syn match   mZcommand       /\c \%(za\%[llocate]\|zb\%[reak]\|zcom\%[pile]\|zc\%[ontinue]\|zd\%[eallocate]\|zed\%[it]\|zg\%[oto]\|zh\%[elp]\|zl\%[ink]\|zm\%[essage]\|zp\%[rint]\|zsh\%[ow]\|zst\%[ep]\|zsy\%[stem]\|ztc\%[ommit]\|zts\%[tart]\|zwi\%[thdraw]\|zwr\%[ite]\)\%([ :]\|$\)/ contained contains=mOperator
syn match   mDoGoCommand    /\<[dDgG]\ze / contained
syn match   mNumber         /\<\d\+\%(\.\d\+\)\?\%(E[-+]\?\d\+\)\?\>\|\.\d\+\>/ contained
syn match   mFunction       /\$[a-zA-Z]\+/ contained
syn match   mFunctionLabel  /\$\$[%A-Za-z0-9][A-Za-z0-9]*\%(\^\%(|[^|]*|\)\?[%A-Za-z][A-Za-z0-9]*\)\?/ contained
syn match   mPName          contained /\<\CP[ADG][A-Za-z0-9]*/
syn match   mUName          contained /\<\CU[ADG][A-Za-z0-9]*/
syn match   mFName          contained /\<\CF[ADG][A-Za-z0-9]*/
syn match   mCName          contained /\<\CC[ADG][A-Za-z0-9]*/
syn match   mRName          contained /\<\CR[ADG][A-Za-z0-9]*/
" Global names follow the ISO name rule, optionally with an extended reference
" (^|"env"|NAME); a bare ^ is a naked reference
syn match   mGlobalName     contained /\^\%(|[^|]*|\)\?\%([%A-Za-z][A-Za-z0-9]*\)\?/
" Macro names contain only the underscore of the m4_ prefix
syn match   mMacroName      contained /\<m4_[A-Za-z0-9]\+/
syn match   mParamLabel     contained /\%([(,]\)\@<=[$A-Za-z0-9]\+=/
" Label (and/or routine) after a do or goto command inside macro arguments
syn match   mDoGoLabel      contained /\c\%(\<\%(d\|do\|g\|goto\)\%(:[^ ]*\)\? \)\@<=\%([%A-Za-z0-9][A-Za-z0-9]*\%(+\d\+\)\?\%(\^\%(|[^|]*|\)\?[%A-Za-z][A-Za-z0-9]*\)\?\|\^\%(|[^|]*|\)\?[%A-Za-z][A-Za-z0-9]*\)/
" Entry references (label[+offset][^routine]) at the start of each do, goto or job argument
syn match   mDoGoArgLabel   contained /\%( \|,\)\@<=\%(m4_\)\@!\%([%A-Za-z0-9][A-Za-z0-9]*\%(+\d\+\)\?\%(\^\%(|[^|]*|\)\?[%A-Za-z][A-Za-z0-9]*\)\?\|\^\%(|[^|]*|\)\?[%A-Za-z][A-Za-z0-9]*\)/
syn match   mLabelEnd       contained ":"
syn match   mPragmaLine     contained ";pragma [a-zA-Z0-9 ,]*" contains=mPragma,mRName,mOperator
syn match   mPragma         contained ";pragma [a-zA-Z0-9]*" contains=mPragmaType
syn match   mPragmaType     contained " [a-zA-Z0-9]*"

" Macro arguments, with nested parentheses so the closing one is found
" (defined after mOperator so these regions win on an opening parenthesis)
syn cluster mMacroArgItems  contains=mParamLabel,mOperator,mString,mNumber,mPName,mUName,mFName,mCName,mRName,mGlobalName,mDoGoCommand,mDoGoLabel,mFunction,mFunctionLabel,mMacroName,mMacroArgs,mParenGroup
syn region  mParenGroup     oneline matchgroup=mParentheses start=/(/ end=/)/ contained contains=@mMacroArgItems
syn region  mExprParen      oneline matchgroup=mParentheses start=/(/ end=/)/ contained contains=@mExpr
syn region  mMacroArgs      oneline matchgroup=mParentheses start=/\%(\<m4_[A-Za-z0-9]\+\)\@<=(/ end=/)/ contained contains=@mMacroArgItems

" Argument list of a command: ends at the next space outside strings and parentheses,
" so nothing inside it is taken for a command
syn cluster mExpr           contains=mString,mOperator,mNumber,mPName,mUName,mFName,mCName,mRName,mGlobalName,mFunction,mFunctionLabel,mMacroName,mMacroArgs,mExprParen,mRegistry
syn region  mArgs           oneline start=/\c\%([ .]\%([bcdefghijklmnoqrsuvwx]\|break\|close\|do\|else\|for\|goto\|halt\|hang\|if\|job\|kill\|lock\|merge\|new\|open\|quit\|read\|set\|use\|view\|write\|xecute\|tr\|tc\|tro\|tre\|ts\|tcommit\|trestart\|trollback\|tstart\|z[a-z]\+\)\%(:[^ ]*\)\? \)\@<=\ze[^ ;]/ end=/\ze \|$/ contained contains=@mExpr
" Do, goto and job arguments start with an entry reference (defined after mArgs so it wins)
syn region  mDoGoArgs       oneline start=/\c\%([ .]\%(d\|do\|g\|goto\|j\|job\)\%(:[^ ]*\)\? \)\@<=\ze[^ ;]/ end=/\ze \|$/ contained contains=mDoGoArgLabel,@mExpr

" Highlights
hi def link mComment       Comment
hi def link mLabelLine     Normal
hi def link mLabelCode     MumpsLabel
hi def link mLabelLabel    MumpsLabelName
hi def link mString        String
hi def link mOperator      Operator
hi def link mParentheses   Operator
hi def link mParamLabel    Operator
hi def link mLabelEnd      Operator
hi def link mCommand       MumpsCommand
hi def link mZcommand      MumpsCommand
hi def link mNumber        Number
hi def link mFunction      MumpsIntrinsicFunction
hi def link mFunctionLabel MumpsIntrinsicFunction
hi def link mPName         MumpsPName
hi def link mUName         MumpsUName
hi def link mFName         MumpsFName
hi def link mCName         MumpsCName
hi def link mRName         MumpsGlobalName
hi def link mGlobalName    MumpsGlobalName
hi def link mMacroName     MumpsMacro
hi def link mRegistry      MumpsMacro
hi def link mDoGoLabel     MumpsDoGoLabel
hi def link mDoGoArgLabel  MumpsDoGoLabel
hi def link mDoGoCommand   MumpsCommand
hi def link mPragma        Function
hi def link mPragmaType    Special

let b:current_syntax = "mfile"
