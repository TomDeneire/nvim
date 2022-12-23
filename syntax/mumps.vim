" Mumps syntax file
" Language:     MUMPS (Brocade .m files)
" Maintainer:   Tom Deneire, tomdeneire@gmail.com
" Last change:  22 December 2022

if exists('b:current_syntax')
    finish
endif

" Remove any old syntax stuff hanging around
syn clear

" Line Structure
syn region  mComment        oneline start="^//" end=/$/
syn region  mComment        oneline start=";" end=/$/ contained
syn region  mLabelLine      oneline start=/^[sub|def|fn]/ end=":" contains=mLabelCode,mLabelLabel,mLabelArgs,mLabelEnd
syn region  mString         oneline start=/"/ skip=/""/ excludenl end=/"/ contained
syn region  mMacro          oneline start="m4_" end=")" contained contains=mMacroName,mMacroArgs
syn region  mMacroArgs      oneline start="(" end=")" contained contains=mParams,mOperator,mString,mNumber,mPName,mUName,mFName,mCName,mGlobalName,mDoGoContained,mFunction
syn region  mLine           oneline start=/^\s/ end=/$/ contains=mString,mOperator,mComment,mCommand,mZcommand,mNumber,mFunction,mFunctionLabel,mMacro,mPName,mUName,mFName,mCName,mGlobalName,mDoGo,mMacroSingle

" Matches
syn match   mLabelCode      /[sub|def|fn]/ contained
syn match   mLabelLabel     / [%a-zA-Z0-9]*/ contained
syn match   mLabelArgs      /([a-zA-Z0-9][,a-zA-Z0-9]*)/ contained contains=mOperator,mPName
syn match   mOperator       "[+,\_\-*/=&#$!'\\\]\[<>?@\(/)«»:. ]" contained contains=mParentheses
syn match   mParentheses    "[()]" contained
syn match   mCommand        " [bcdefghijklmnrsuvwxq][ :]" contained contains=mOperator
syn match   mCommand        / tr / contained
syn match   mCommand        / tc / contained
syn match   mCommand        / tro / contained
syn match   mCommand        / tre / contained
syn match   mCommand        / ts / contained
syn match   mCommand        / [dq]\n/ contained
syn keyword mZcommand       contained za[llocate] zb[reak] zcom[pile] zc[ontinue] zd[eallocate]
syn keyword mZcommand       contained zed[it] zg[oto] zh[elp] zl[ink] zm[essage] zp[rint]
syn keyword mZcommand       contained zsh[ow] zst[ep] zsy[stem] ztc[ommit] zts[tart]
syn keyword mZcommand       contained zwi[thdraw] zwr[ite]
syn match   mDoGoCommand    /[dg] / contained
syn match   mNumber         /[0-9][0-9]*/ contained
syn match   mFunction       /$[a-zA-Z]*/ contained
syn match   mFunctionLabel  /$$[a-zA-Z]*/ contained
syn match   mPName          /\<\CP[A|D|G][A-Za-z0-9]*/ contained
syn match   mUName          contained /\<\CU[A|D|G][A-Za-z0-9]*/
syn match   mFName          contained /\<\CF[A|D|G][A-Za-z0-9]*/
syn match   mCName          contained /\<\CC[A|D|G][A-Za-z0-9]*/
syn match   mGlobalName     contained /\^[A-Z0-9]*/
syn match   mMacroName      contained /m4_[a-zA-Z0-9]*/
syn match   mMacroSingle    contained /m4_[a-zA-Z0-9]*[, \n]/ contains=mMacroName
syn match   mParams         contained /[$a-zA-Z0-9]*=["a-zA-Z0-9]*/ contains=mOperator,mParamLabel,mString,mNumber,mPName,mUName,mFName,mCName,mGlobalName
syn match   mParamLabel     contained /[$a-zA-Z0-9]*=/
syn match   mDoGo           contained / [dg] [%a-zA-Z0-9][\^a-zA-Z0-9]*/ contains=mCommand,mDoGoLabel
syn match   mDoGoContained  contained /[dg] [%a-zA-Z0-9][\^a-zA-Z0-9]*/ contains=mDoGoCommand,mDoGoLabel
syn match   mDoGoLabel      contained /[%a-zA-Z0-9][\^a-zA-Z0-9][\^a-zA-Z0-9]*/
syn match   mLabelEnd       contained ":"


" Highlights
hi! link mComment       Comment
hi! link mLabelLine     Normal
hi! link mLabelCode     MumpsLabel
hi! link mLabelLabel    MumpsLabelName
hi! link mString        String
hi! link mOperator      Operator
hi! link mParentheses   Operator
hi! link mParamLabel    Operator
hi! link mLabelEnd      Operator
hi! link mCommand       MumpsCommand
hi! link mZcommand       MumpsCommand
hi! link mNumber        Number
hi! link mFunction      MumpsIntrinsicFunction
hi! link mFunctionLabel MumpsIntrinsicFunction
hi! link mPName         MumpsPName
hi! link mUName         MumpsUName
hi! link mFName         MumpsFName
hi! link mCName         MumpsCName
hi! link mGlobalName    MumpsGlobalName
hi! link mMacroName     MumpsMacro
hi! link mDoGoLabel     MumpsDoGoLabel
hi! link mDoGoCommand   MumpsCommand
