" Vim syntax file
" Language:	Package List
" Maintainer:	Curtis Anderson <curtis.anderson@intel.com>
" Last Change:	2022 May 2
" Version:	2

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn clear
syn case match

" TODO Syntax rules.

" Headings (labels followed by a colon ":")
syn match	pkgHeading	/^[-_a-zA-Z0-9]\+:/

" Environment variables
syn match	pkgVariable	/\$([-_a-zA-Z0-9]\+)/

" Macro invocations
syn match	pkgMacro	/@[-_.a-zA-Z0-9]\+/
syn region	pkgMacroFunc	matchgroup=pkgMacro start=/@[-_.a-zA-Z0-9]\+(/ end=/)/ contains=pkgVariable,pkgMacroVar
syn match	pkgMacroVar	/{[-_:a-zA-Z0-9]\+}/

" Groups
setlocal iskeyword+=:
syn keyword	pkgGroup	Group: nextgroup=pkgGroupName,pkgGroupFunc skipwhite
syn match	pkgGroupName	/[-_.a-zA-Z0-9]\+/ contained
syn region	pkgGroupFunc	matchgroup=pkgGroupName start=/[-_.a-zA-Z0-9]\+(/ end=/)/ contained

" Comments
syn region	pkgComment	start=/#.*/ end=/$/ keepend contains=pkgPreproc,pkgCommentTodo
syn region	pkgPreProc	start=/!.*/ end=/$/ keepend contains=pkgInclude contained

" Include
syn keyword	pkgInclude	include nextgroup=pkgIncPath contained skipwhite
syn match	pkgIncPath	/\S\+/ contains=pkgVariable contained

" Special paths
syn region	pkgPathPrefix	matchgroup=pkgPathMod start=/\[/ end=/\]/ contains=pkgVariable,pkgMacroVar

" Platform specific files
syn region	pkgPlatform	matchgroup=pkgPathMod start=/(+/ end=/)/ contains=pkgPlatName
syn keyword	pkgPlatName	windows linux contained

" Special comment keywords
syn keyword	pkgCommentTodo	TODO FIXME HSD XXX contained


" TODO Default highlighting.

hi def link	pkgHeading	Keyword
hi def link	pkgVariable	Identifier
hi def link	pkgMacro	Macro
hi def link	pkgMacroVar	Underlined
hi def link	pkgGroup	Keyword
hi def link	pkgGroupName	Define
hi def link	pkgComment	Comment
hi def link	pkgCommentTodo	Todo
hi def link	pkgPreProc	Macro
hi def link	pkgInclude	Macro
hi def link	pkgIncPath	String
hi def link	pkgPathMod	Special
hi def link	pkgPlatName	StorageClass

let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = "pkglist"
