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

" Decl block
syn region	simDeclBlock	matchgroup=simDeclMatch start=/decl\s\+{/ end=/}/ contains=declComment,declParam,declParams,declGroup,declFrom,declType,simComment,simString,simNumber,simConstant
syn region	declComment	start=/!.*/ end=/$/ contained
syn keyword	declGroup	group or except contained
syn keyword	declParam	param result default contained
syn keyword	declParams	params nextgroup=declFrom contained
syn keyword	declFrom	from contained
syn keyword	declType	int string nil bool file contained
syn region	declType	start=/{/ end=/}/ contains=simString contained



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
hi def link	declParam	Keyword
hi def link	declParams	Keyword
hi def link	declFrom	Keyword
hi def link	declType	StorageClass
hi def link	declGroup	Keyword

let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = "simics"
