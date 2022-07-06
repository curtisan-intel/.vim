" Vim syntax file
" Language:	Simics 6 Script
" Maintainer:	Curtis Anderson <curtis.anderson@intel.com>
" Last Change:	2022 April 14
" Version:	2

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn clear
syn case match

" TODO Syntax rules.

" Control-flow keywords
syn keyword	simConditional	if else
syn keyword	simException	try except throw
syn keyword	simRepeat	while foreach in

" Numbers and boolean constants
syn keyword	simConstant	TRUE FALSE NIL

syn match	simNumber	"\<\d\+\>"
syn match	simNumber	"\<0x\x\+\>"
syn match	simNumber	"\<0b[01]\+\>"

" Named boolean operators
syn keyword	simBooleanOp	and or not

" Strings and characters
syn region	simString	start=/"/ skip=/\\"/ end=/"/
syn region	simString	start=/'/ skip=/\\'/ end=/'/

" Comments and comment URLs
syn keyword	simCommentFix	TODO FIXME HSD XXX contained
syn match	simCommentURL	"https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*" contained
syn region	simComment	start=/#.*/ end=/$/ contains=simCommentFix,simCommentURL

" Reference to named variable
syn match	simVariable	"\$[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*"
syn match	simVariable	"%[a-zA-Z_][a-zA-Z0-9_]*%"

" Defined boolean test
syn keyword	simDefined	defined nextgroup=simDefineVal skipwhite
syn match	simDefineVal	"[a-zA-Z_][a-zA-Z0-9_]*" contained

" Variable types and storage
syn keyword	simStorage	local unset

" Command flags
syn match	simCommandFlag	"\s\+-\{1,2}[a-zA-Z][-a-zA-Z0-9]*"

" Command names
"     Parsing command names proves to be too problematic.  There are incorrect
"   matches, and many special cases even for correct matches.  It has been
"   decided that it is better to keep the good highlighting we have than to
"   mess it up with improper command name highlighting.
"     Command names are user-defined, anyway.  So it is not really expected
"   that they will be highlighted, given the other Vim syntax files.
"
" syn match	simCommandPre	/\(^\|(\|{\)/ nextgroup=simCommand skipwhite
" syn match	simCommand	/[a-zA-Z]\+\(-[a-zA-Z0-9]\+\)*/ contained contains=simConditional,simException,simRepeat,simBooleanOp,simDefined,simStorage

" Python lines
let b:current_syntax = ''
unlet b:current_syntax
syn include	@Python		syntax/python.vim
syn region	simPython	start=/@/ms=s+1 end=/$/ contains=@Python keepend
syn region	simPython	start=/`/ms=s+1 end=/`/me=e-1 contains=@Python keepend

" Shell lines
let b:current_syntax = ''
unlet b:current_syntax
syn include	@Shell		syntax/sh.vim
syn region	simShell	start=/![^=]/ms=s+1 end=/$/ contains=@Shell keepend

" Declarations and parameters
syn region	simDeclBlock	matchgroup=simDeclMatch start=/decl\s\+{/ end=/}/ contains=@simDecls
syn cluster	simDecls	contains=declParam,declResult,declParams,declGroup,declComment,simComment,declExcept,declDefault
syn match	declName	/[a-zA-Z_][a-zA-Z0-9_]*/ contained
syn region	declComment	start=/!.*/ end=/$/ contained

syn keyword	declValBool	TRUE FALSE contained
syn keyword	declValNil	NIL contained
syn match	declValString	/[a-zA-Z_][a-zA-Z0-9_]*/ contained
syn region	declValString	start=/"/ skip=/\\"/ end=/"/ contained
syn match	declValInt	"\<[-]\?\d\+" contained nextgroup=declValFloat
syn match	declValInt	"\<0x\x\+\>" contained
syn match	declValInt	"\<0b[01]\+\>" contained
syn match	declValFloat	"\.\d\+\%(e[-+]\=\d\+\)\?\>" contained
syn match	declValFloat	"e[-+]\=\d\+\>" contained

syn cluster	declVals	contains=declValBool,declValNil,declValString,declValInt

syn region	declFilePattern	start=/"/ end=/"/ contained contains=declFileWC
syn match	declFileWC	/\*/ contained
syn match	declFileWC	/%simics%/ contained

" Param declarations
syn keyword	declParam	param contained nextgroup=declParamName skipwhite
syn match	declParamName	/[a-zA-Z_][a-zA-Z0-9_]*/ contained nextgroup=declParamColon skipwhite
syn match	declParamColon	/:/ contained nextgroup=declParamType skipwhite

syn keyword	declParamType	int float string bool contained nextgroup=declParamOr,declParamVal skipwhite
syn region	declParamType	start=/file(/ end=/)/ contained contains=declFilePattern nextgroup=declParamOr,declParamVal skipwhite
syn region	declParamType	start=/{/ end=/}/ contained contains=@declVals nextgroup=declParamOr,declParamVal skipwhite

syn keyword	declParamOr	or contained nextgroup=declParamNil skipwhite
syn keyword	declParamNil	nil contained nextgroup=declParamVal skipwhite

syn match	declParamVal	/=/ contained nextgroup=@declVals skipwhite

" Result declarations
syn keyword	declResult	result contained nextgroup=declResultName skipwhite
syn match	declResultName	/[a-zA-Z_][a-zA-Z0-9_]*/ contained nextgroup=declResultColon skipwhite
syn match	declResultColon	/:/ contained nextgroup=declResultType skipwhite

syn keyword	declResultType	int float string bool contained nextgroup=declResultOr skipwhite
syn region	declResultType	start=/file(/ end=/)/ contained contains=declFilePattern nextgroup=declResultOr skipwhite
syn region	declResultType	start=/{/ end=/}/ contained contains=@declVals nextgroup=declResultOr skipwhite

syn keyword	declResultOr	or contained nextgroup=declResultNil skipwhite
syn keyword	declResultNil	nil contained skipwhite

" Groups
syn keyword	declGroup	group contained nextgroup=declGroupName skipwhite
syn region	declGroupName	start=/"/ skip=/\\"/ end=/"/ contained

" Imported parameters
syn match	declParams	/params\s\+from/ contained nextgroup=declScriptName skipwhite
syn region	declScriptName	start=/"/ skip=/\\"/ end=/"/ contained nextgroup=declExcept,declDefault skipwhite skipnl
syn keyword	declExcept	except contained nextgroup=declExFirst skipwhite skipnl
syn match	declExFirst	/[a-zA-Z_][a-zA-Z0-9_]*/ contained nextgroup=declExNext,declDefault skipwhite skipnl
syn match	declExNext	/,/ contained nextgroup=declExFirst skipwhite skipnl
syn keyword	declDefault	default contained nextgroup=declDefName skipwhite skipnl
syn match	declDefName	/[a-zA-Z_][a-zA-Z0-9_]*/ contained nextgroup=declDefVal skipwhite skipnl
syn match	declDefVal	/=/ contained nextgroup=declDValBool,declDValNil,declDValString,declDValInt skipwhite skipnl

syn keyword	declDValBool	TRUE FALSE contained nextgroup=declDefault skipwhite skipnl
syn keyword	declDValNil	NIL contained nextgroup=declDefault skipwhite skipnl
syn match	declDValString	/[a-zA-Z_][a-zA-Z0-9_]*/ contained nextgroup=declDefault skipwhite skipnl
syn region	declDValString	start=/"/ skip=/\\"/ end=/"/ contained nextgroup=declDefault skipwhite skipnl
syn match	declDValInt	"\<[-]\?\d\+" contained nextgroup=declDValFloat,declDefault skipwhite skipnl
syn match	declDValInt	"\<0x\x\+\>" contained nextgroup=declDefault skipwhite skipnl
syn match	declDValInt	"\<0b[01]\+\>" contained nextgroup=declDefault skipwhite skipnl
syn match	declDValFloat	"\.\d\+\%(e[-+]\=\d\+\)\?\>" contained nextgroup=declDefault skipwhite skipnl
syn match	declDValFloat	"e[-+]\=\d\+\>" contained nextgroup=declDefault skipwhite skipnl



" Default highlighting.

hi def link	simConditional	Conditional
hi def link	simException	Exception
hi def link	simRepeat	Repeat

hi def link	simConstant	Constant
hi def link	simNumber	Number

hi def link	simBooleanOp	Operator

hi def link	simString	String

hi def link	simCommentFix	Todo
hi def link	simCommentURL	Underlined
hi def link	simComment	Comment

hi def link	simVariable	Identifier

hi def link	simDefined	Operator
hi def link	simDefineVal	Define

hi def link	simStorage	StorageClass

hi def link	simCommandFlag	Special

hi def link	simDeclMatch	Macro
hi def link	declComment	Comment

hi def link	declValBool	Constant
hi def link	declValNil	Constant
hi def link	declValInt	Number
hi def link	declValFloat	Number
hi def link	declValString	String
hi def link	declDValBool	Constant
hi def link	declDValNil	Constant
hi def link	declDValInt	Number
hi def link	declDValFloat	Number
hi def link	declDValString	String

hi def link	declParam	Keyword
hi def link	declResult	Keyword
hi def link	declGroup	Keyword
hi def link	declParams	Keyword
hi def link	declParamOr	Keyword
hi def link	declResultOr	Keyword
hi def link	declExcept	Keyword
hi def link	declDefault	Keyword
hi def link	declParamType	Type
hi def link	declResultType	Type
hi def link	declParamNil	Type
hi def link	declResultNil	Type

hi def link	declParamColon	Operator
hi def link	declResultColon	Operator
hi def link	declParamVal	Operator
hi def link	declDefVal	Operator

hi def link	declParamName	Identifier
hi def link	declResultName	Identifier
hi def link	declGroupName	String
hi def link	declScriptName	String
hi def link	declExFirst	Identifier
hi def link	declDefName	Identifier

hi def link	declFilePattern	String
hi def link	declFileWC	Underlined


let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = "simics"
