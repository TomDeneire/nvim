" Mumps syntax file
" Language:	MUMPS (Brocade .m files)
" Maintainer:	Tom Deneire, tomdeneire@gmail.com
" Last change:	6 December 2022

" related formatting, jas 24Sept03 - experimental
set lbr
set breakat=\ ,
set showbreak=\ \ \ \ \ \ \ +\

" Remove any old syntax stuff hanging around
syn clear
syn sync    maxlines=0
syn sync    minlines=0
" syn case    ignore

"errors
"syn match   mumpsError          contained /[^ \t;].\+/
"syn match   mumpsBadString 	/".*/
" Catch mismatched parentheses
"syn match   mumpsParenError	/).*/
"syn match   mumpsBadParen	/(.*/


" Line Structure
syn region  mumpsComment        contained start=/;/ end=/$/
syn region  mumpsComment        contained start=/\/\// end=/\n/

"syn region  mumpsFormalArgs	contained oneline start=/(/ end=/)/ contains=mumpsLocalName,","
syn match   mumpsDotLevel	contained /\.[. \t]*/

syn region  mumpsCmd		contained oneline start=/[A-Za-z]/ end=/[ \t]/ end=/$/ contains=mumpsCommand,mumpsZCommand,mumpsPostCondition,mumpsError nextgroup=mumpsArgsSeg

syn match   mumpsMacro          contained /m4_[A-Za-z0-9]*/ nextgroup=mumpsMacroArgs
syn match   mumpsMacroArgs	contained /\(.*\)/ contains=mumpsLocalName,mumpsGlobalName,mumpsString,mumpsNumber,mumpsMacroTags,mumpsOperator,mumpsMacroParams,mumpsDoGoCmd
syn match mumpsMacroTags 	contained /[,()=,$]/
syn match mumpsMacroParams	contained /$[A-Za-z0-9]*=[A-Za-z0-9\"^]*/ contains=mumpsMacroParamId,mumpsString
syn match mumpsMacroParamId	contained /$/
" syn match   mumpsMacro   contained /m4_Routine\(.*\)/ contains=mumpsRoutinename,mumpsDoGoCmd,mumpsOperator
" syn match mumpsRoutinename      contained /m4_Routine/

syn region  mumpsPostCondition	contained oneline start=/:/hs=s+1 end=/[ \t]/re=e-1,he=e-1,me=e-1 end=/$/ contains=mumpsPostOperator,@mumpsExpr
syn match mumpsPostOperator contained /:/

syn region  mumpsArgsSeg	contained oneline start=/[ \t]/lc=1 end=/[ \t]\+/ end=/$/ contains=@mumpsExpr,",",mumpsPostCondition

syn match   mumpsLineStart      contained /^[ \t][. \t]*/
syn match   mumpsLineStart      contained /^[%A-Za-z][^ \t;]*[. \t]*/ contains=mumpsBrocLabel,mumpsDotLevel
syn region  mumpsLine		start=/^/ keepend end=/$/ contains=mumpsCmd,mumpsLineStart,mumpsComment,mumpsMacro,mumpsForLoop,mumpsDoGo,mumpsRoutineMacro

syn match mumpsForLoop          contained /f  s [A-Za-z0-9$(),\"]*=[A-Za-z0-9$(),\"]* q:[A-Za-z0-9$(),\"]*=[A-Za-z0-9$(),\"]*  d/ contains=mumpsForOperator,mumpsExpr,mumpsIntrinsic,mumpsPostCondition
syn match mumpsForOperator	contained /f  /
syn match mumpsForOperator	contained /s /
syn match mumpsForOperator	contained / q/
syn match mumpsForOperator	contained /  d/

syn match mumpsDoGo           contained /[dg]\s[\@]*[\%]*[A-Za-z0-9]*[\^[A-Za-z0-9]*]*[\(.*\)]*/ contains=mumpsDoGoCmd,mumpsDoGoLabel,mumpsMacroArgs,mumpsDoGoIndirect
syn match mumpsDoGoIndirect        contained "@"
syn match mumpsDoGoCmd        contained /[dg]/
syn match mumpsDoGoLabel      contained /\s[\%]*[A-Za-z0-9]*[\^[A-Za-z0-9]*]*/

syn cluster mumpsExpr     	contains=mumpsVar,mumpsIntrinsic,mumpsExtrinsic,mumpsString,mumpsParen,mumpsOperator,mumpsBadString,mumpsBadNum,mumpsVRecord,mumpsLocalName,mumpsGlobalName,mumpsNumber

" syn match   mumpsVar		contained /\^=[%A-Za-z][A-Za-z0-9]*/ nextgroup=mumpsSubs
syn match   mumpsIntrinsic 	contained /$[%A-Za-z][A-Za-z0-9]*/ contains=mumpsIntrinsicFunc,mumpsZInFunc,mumpsSpecialVar,mumpsZVar nextgroup=mumpsParams
syn match   mumpsExtrinsic	contained /$$[%A-Za-z][A-Za-z0-9]*\(^[%A-Za-z][A-Za-z0-9]*\)\=/ contains=mumpsExtrinsicFunc nextgroup=mumpsParams
syn match mumpsParams contained /\(\S*\)/ contains=mumpsLocalName,mumpsGlobalName,mumpsString,mumpsOperator

syn match mumpsGlobalName	/\^[A-Z0-9]*/
syn match   mumpsLocalName	contained /[%A-Za-z][A-Za-z0-9]*/ contains=mumpsPName,mumpsUName,mumpsFName
syn match   mumpsPName		contained /\<\CP[A|D|G][A-Za-z0-9]*/
syn match   mumpsUName		contained /\<\CU[A|D|G][A-Za-z0-9]*/
syn match   mumpsFName		contained /\<\CF[A|D|G][A-Za-z0-9]*/


" Operators
syn match   mumpsOperator       contained "[+,\_\-*/=&#!'\\\]\[<>?@\(/)«»:.]"
syn match   mumpsOperator       contained "]]"
syn region  mumpsVRecord	contained start=/[= \t,]</lc=1 end=/>/ contains=mumpsLocalName,","

" Constants
syn region  mumpsString 	contained oneline start=/"/ skip=/""/ excludenl end=/"/ oneline
syn match   mumpsBadNum 	contained /\<0\d+\>/
syn match   mumpsBadNum 	contained /\<\d*\.\d*0\>/
syntax match mumpsNumber /[0-9]\+/ display contained
syn match   mumpsNumber 	contained /\<\d*\.\d{1,9}\>/
syn match   mumpsNumber 	contained /\<\d+\>/

syn region  mumpsParen     	contained oneline start=/(/ end=/)/ contains=@mumpsExpr
syn region  mumpsSubs		contained oneline start=/(/ end=/)/ contains=@mumpsExpr,","
syn region  mumpsActualArgs	contained oneline start=/(/ end=/)/ contains=@mumpsExpr,","

" Keyword definitions -------------------
"-- Commands --
syn keyword mumpsCommand	contained B[reak] C[lose] D[o] E[lse] F[or] G[oto] H[alt] H[ang]
syn keyword mumpsCommand 	contained I[f] J[ob] K[ill] L[ock] M[erge] N[ew] O[pen] Q[uit]
syn keyword mumpsCommand 	contained R[ead] S[et] TC[ommit] TRE[start] TRO[llback] TS[tart]
syn keyword mumpsCommand 	contained U[se] V[iew] W[rite] X[ecute]
syn keyword mumpsCommand	contained b[reak] c[lose] d[o] e[lse] f[or] g[oto] h[alt] h[ang]
syn keyword mumpsCommand 	contained i[f] j[ob] k[ill] l[ock] m[erge] n[ew] o[pen] q[uit]
syn keyword mumpsCommand 	contained r[ead] s[et] TC[ommit] tre[start] tro[llback] ts[tart]
syn keyword mumpsCommand 	contained u[se] v[iew] w[rite] x[ecute]

"  -- Brocade specific --
syn region mumpsBrocLabel 	oneline start=/^sub/ end=":" contains=mumpsLabel,mumpsLabelName,mumpsLabelArgs,mumpsLabelColon
syn region mumpsBrocLabel 	oneline start=/^fn/ end=":" contains=mumpsLabel,mumpsLabelName,mumpsLabelArgs,mumpsLabelColon
syn region mumpsBrocLabel 	oneline start=/^def/ end=":" contains=mumpsLabel,mumpsLabelName,mumpsLabelArgs,mumpsLabelColon
syn match mumpsLabelName contained /[%A-Za-z0-9]*/
syn match mumpsLabel contained /^def/
syn match mumpsLabel contained /^sub/
syn match mumpsLabel contained /^fn/
syn match mumpsLabelColon contained ":"
syn region mumpsLabelArgs contained oneline start=/(/ end=/)/ contains=mumpsLabelTags,mumpsLocalName
syn match mumpsLabelTags contained /[\(\):]/

"  -- GT.M specific --
syn keyword mumpsZCommand 	contained ZA[llocate] ZB[reak] ZCOM[pile] ZC[ontinue] ZD[eallocate]
syn keyword mumpsZCommand 	contained ZED[it] ZG[oto] ZH[elp] ZL[ink] ZM[essage] ZP[rint]
syn keyword mumpsZCommand 	contained ZSH[ow] ZST[ep] ZSY[stem] ZTC[ommit] ZTS[tart]
syn keyword mumpsZCommand 	contained ZWI[thdraw] ZWR[ite]
syn keyword mumpsZcommand 	contained za[llocate] zb[reak] zcom[pile] zc[ontinue] zd[eallocate]
syn keyword mumpsZcommand 	contained zed[it] zg[oto] zh[elp] zl[ink] zm[essage] zp[rint]
syn keyword mumpsZcommand 	contained zsh[ow] zst[ep] zsy[stem] ztc[ommit] zts[tart]
syn keyword mumpsZcommand 	contained zwi[thdraw] zwr[ite]

"-- Intrinsic Functions
syn keyword mumpsIntrinsicFunc	contained A[scii] C[har] D[ata] E[xtract] F[ind] FN[umber] G[et]
syn keyword mumpsIntrinsicFunc	contained J[ustify] L[ength] N[ame] N[ext] O[rder] P[iece]
syn keyword mumpsIntrinsicFunc	contained Q[uery] R[andom] S[elect] T[ext] T[ranslate] V[iew]

" -- GT.M z-functions --
syn keyword mumpsZInFunc	contained ZD[ate] ZM[essage] ZPARSE ZP[revious] ZSEARCH ZTRNLNM

" Special Variables
"syn keyword mumpsSpecialVar	contained D[evice] H[orolog] I[O] J[ob] K[ey] P[rincipal]
"syn keyword mumpsSpecialVar	contained S[torage] T[est] TL[evel] TR[estart] X Y

"-- GT.M specific --
syn keyword mumpsZVar	contained ZCSTATUS ZDIR[ectory] ZEDIT ZEOF ZGBL[dir]
syn keyword mumpsZVar	contained ZIO ZL[evel] ZPOS[ition] ZPROMP[t] ZRO[utines]
syn keyword mumpsZVar	contained ZSO[urce] ZS[tatus] ZSYSTEM ZT[rap] ZVER[sion]

" The default methods for hilighting.  Can be overridden later
hi! link mumpsCommand		MumpsCommand
hi! link mumpsZCommand    MumpsCommand
hi! link mumpsIntrinsicFunc   MumpsIntrinsicFunction
hi! link mumpsZInFunc		Preproc
hi! link mumpsSpecialVar      Error
hi! link mumpsZVar		PreProc
hi! link mumpsLineStart	Statement
hi! link mumpsLabel		MumpsLabel
hi! link mumpsLabelTags	Function
hi! link mumpsFormalArgs	MumpsFormalArgs
hi! link mumpsDotLevel	PreProc
hi! link mumpsLineStart	Normal
hi! link mumpsCmdSeg		Special
hi! link mumpsPostCondition	MumpsVariable
hi! link mumpsCmd		Statement
hi! link mumpsArgsSeg		MumpsVariable
hi! link mumpsExpr		PreProc
" hi! link mumpsVar		MumpsGlobalName
hi! link mumpsGlobalName	MumpsGlobalName
hi! link mumpsParen           MumpsVariable
hi! link mumpsSubs            MumpsVariable
hi! link mumpsActualArgs      Special
hi! link mumpsIntrinsic       MumpsIntrinsicFunction
hi! link mumpsExtrinsic	MumpsIntrinsicFunction
hi! link mumpsString		String
hi! link mumpsNumber		Number
hi! link mumpsOperator	Operator
hi! link mumpsLabelColon	Operator
hi! link mumpsDoGoIndirect	Operator
hi! link mumpsComment		Comment
hi! link mumpsPostOperator	Special
hi! link mumpsMacro		MumpsMacro
hi! link mumpsMacroArgs	Statement
hi! link mumpsError		Error
hi! link mumpsBadNum		Error
hi! link mumpsBadString	Error
hi! link mumpsBadParen	Error
hi! link mumpsParenError	Error
hi! link mumpsBrocLabel	MumpsLabel
hi! link mumpsLabelName	MumpsLabelName
hi! link mumpsPName		MumpsPName
hi! link mumpsUName		MumpsUName
hi! link mumpsFName		MumpsFName
hi! link mumpsForOperator	MumpsCommand
hi! link mumpsMacroParamId	Function
hi! link mumpsDoGoCmd	        MumpsCommand
hi! link mumpsDoGoLabel         MumpsDoGoLabel

let b:current_syntax = "mumps"

" vim: ts=8
