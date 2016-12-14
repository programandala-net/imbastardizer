" Vim syntax file
" Language:		GW-BASIC
" Maintainer:	Marcos Cruz (programandala.net)
" License:		Vim license (GPL compatible)
" URL:			http://programandala.net/
" Last Change:  2016-12-14

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword gwbasicKeyword ABS
syn keyword gwbasicKeyword ASC
syn keyword gwbasicKeyword ATN
syn keyword gwbasicKeyword AUTO
syn keyword gwbasicKeyword BASE
syn keyword gwbasicKeyword BEEP
syn keyword gwbasicKeyword BLOAD
syn keyword gwbasicKeyword BSAVE
syn keyword gwbasicKeyword CALL
syn keyword gwbasicKeyword CDBL
syn keyword gwbasicKeyword CHAIN
syn keyword gwbasicKeyword CHDIR
syn keyword gwbasicKeyword CHR$
syn keyword gwbasicKeyword CINT
syn keyword gwbasicKeyword CIRCLE
syn keyword gwbasicKeyword CLEAR
syn keyword gwbasicKeyword CLOSE
syn keyword gwbasicKeyword CLS
syn keyword gwbasicKeyword COLOR
syn keyword gwbasicKeyword COM
syn keyword gwbasicKeyword COMMON
syn keyword gwbasicKeyword CONT
syn keyword gwbasicKeyword COS
syn keyword gwbasicKeyword CSNG
syn keyword gwbasicKeyword CSRLIN
syn keyword gwbasicKeyword CVD
syn keyword gwbasicKeyword CVI
syn keyword gwbasicKeyword CVS
syn keyword gwbasicKeyword DATA
syn keyword gwbasicKeyword DATE$
syn keyword gwbasicKeyword DEF
syn keyword gwbasicKeyword DEFDBL
syn keyword gwbasicKeyword DEFINT
syn keyword gwbasicKeyword DEFSNG
syn keyword gwbasicKeyword DEFSTR
syn keyword gwbasicKeyword DELETE
syn keyword gwbasicKeyword DIM
syn keyword gwbasicKeyword DRAW
syn keyword gwbasicKeyword EDIT
syn keyword gwbasicKeyword END
syn keyword gwbasicKeyword ENVIRON
syn keyword gwbasicKeyword ENVIRON$
syn keyword gwbasicKeyword EOF
syn keyword gwbasicKeyword ERASE
syn keyword gwbasicKeyword ERDEV
syn keyword gwbasicKeyword ERL
syn keyword gwbasicKeyword ERR
syn keyword gwbasicKeyword ERROR
syn keyword gwbasicKeyword EXP
syn keyword gwbasicKeyword EXTERR
syn keyword gwbasicKeyword FIELD
syn keyword gwbasicKeyword FILES
syn keyword gwbasicKeyword FIX
syn keyword gwbasicKeyword FN
syn keyword gwbasicKeyword FOR
syn keyword gwbasicKeyword FRE
syn keyword gwbasicKeyword GET
syn keyword gwbasicKeyword GOSUB
syn keyword gwbasicKeyword GOTO
syn keyword gwbasicKeyword HEX$
syn keyword gwbasicKeyword IF
syn keyword gwbasicKeyword INKEY$
syn keyword gwbasicKeyword INP
syn keyword gwbasicKeyword INPUT
syn keyword gwbasicKeyword INPUT$
syn keyword gwbasicKeyword INSTR
syn keyword gwbasicKeyword INT
syn keyword gwbasicKeyword IOCTL
syn keyword gwbasicKeyword IOCTL$
syn keyword gwbasicKeyword KEY
syn keyword gwbasicKeyword KILL
syn keyword gwbasicKeyword LEFT$
syn keyword gwbasicKeyword LEN
syn keyword gwbasicKeyword LET
syn keyword gwbasicKeyword LINE
syn keyword gwbasicKeyword LIST
syn keyword gwbasicKeyword LLIST
syn keyword gwbasicKeyword LOAD
syn keyword gwbasicKeyword LOC
syn keyword gwbasicKeyword LOCATE
syn keyword gwbasicKeyword LOCK
syn keyword gwbasicKeyword LOF
syn keyword gwbasicKeyword LOG
syn keyword gwbasicKeyword LPOS
syn keyword gwbasicKeyword LPRINT
syn keyword gwbasicKeyword LSET
syn keyword gwbasicKeyword MERGE
syn keyword gwbasicKeyword MID$
syn keyword gwbasicKeyword MKD$
syn keyword gwbasicKeyword MKDIR
syn keyword gwbasicKeyword MKI$
syn keyword gwbasicKeyword MKS$
syn keyword gwbasicKeyword NAME
syn keyword gwbasicKeyword NEW
syn keyword gwbasicKeyword NEXT
syn keyword gwbasicKeyword OCT$
syn keyword gwbasicKeyword ON
syn keyword gwbasicKeyword OPEN
syn keyword gwbasicKeyword OPTION
syn keyword gwbasicKeyword OUT
syn keyword gwbasicKeyword PAINT
syn keyword gwbasicKeyword PALETTE
syn keyword gwbasicKeyword PCOPY
syn keyword gwbasicKeyword PEEK
syn keyword gwbasicKeyword PEN
syn keyword gwbasicKeyword PLAY
syn keyword gwbasicKeyword PMAP
syn keyword gwbasicKeyword POINT
syn keyword gwbasicKeyword POKE
syn keyword gwbasicKeyword POS
syn keyword gwbasicKeyword PRESET
syn keyword gwbasicKeyword PRINT
syn keyword gwbasicKeyword PSET
syn keyword gwbasicKeyword PUT
syn keyword gwbasicKeyword RANDOMIZE
syn keyword gwbasicKeyword READ
syn keyword gwbasicKeyword REM
syn keyword gwbasicKeyword RENUM
syn keyword gwbasicKeyword RESET
syn keyword gwbasicKeyword RESTORE
syn keyword gwbasicKeyword RESUME
syn keyword gwbasicKeyword RETURN
syn keyword gwbasicKeyword RIGHT$
syn keyword gwbasicKeyword RMDIR
syn keyword gwbasicKeyword RND
syn keyword gwbasicKeyword RSET
syn keyword gwbasicKeyword RUN
syn keyword gwbasicKeyword SAVE
syn keyword gwbasicKeyword SCREEN
syn keyword gwbasicKeyword SEG
syn keyword gwbasicKeyword SGN
syn keyword gwbasicKeyword SHELL
syn keyword gwbasicKeyword SIN
syn keyword gwbasicKeyword SOUND
syn keyword gwbasicKeyword SPACE$
syn keyword gwbasicKeyword SPC
syn keyword gwbasicKeyword SQR
syn keyword gwbasicKeyword STICK
syn keyword gwbasicKeyword STOP
syn keyword gwbasicKeyword STR$
syn keyword gwbasicKeyword STRIG
syn keyword gwbasicKeyword STRING$
syn keyword gwbasicKeyword SWAP
syn keyword gwbasicKeyword SYSTEM
syn keyword gwbasicKeyword TAB
syn keyword gwbasicKeyword TAN
syn keyword gwbasicKeyword TIME$
syn keyword gwbasicKeyword TIMER
syn keyword gwbasicKeyword TROFF
syn keyword gwbasicKeyword TRON
syn keyword gwbasicKeyword UNLOCK
syn keyword gwbasicKeyword USING
syn keyword gwbasicKeyword USR
syn keyword gwbasicKeyword VAL
syn keyword gwbasicKeyword VARPTR
syn keyword gwbasicKeyword VARPTR$
syn keyword gwbasicKeyword VIEW
syn keyword gwbasicKeyword WAIT
syn keyword gwbasicKeyword WEND
syn keyword gwbasicKeyword WHILE
syn keyword gwbasicKeyword WIDTH
syn keyword gwbasicKeyword WINDOW
syn keyword gwbasicKeyword WRITE

syn keyword gwbasicTodo contained	TODO

"integer number, or floating point number without a dot.
syn match  gwbasicNumber		"\<\d\+\>"
"floating point number, with dot
syn match  gwbasicNumber		"\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  gwbasicNumber		"\.\d\+\>"

" String and Character contstants
syn match   gwbasicSpecial contained "\\\d\d\d\|\\."
syn region  gwbasicString		  start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=basicSpecial

syn region  gwbasicComment	start="REM" end="$" contains=basicTodo
syn region  gwbasicComment	start="^[ \t]*'" end="$" contains=basicTodo
syn region  gwbasicLineNumber	start="^\d" end="\s"
syn match   gwbasicTypeSpecifier  "[a-zA-Z0-9][\$%&!#]"ms=s+1
" Used with OPEN statement
syn match   gwbasicFilenumber  "#\d\+"
"syn sync ccomment gwbasicComment
" syn match   gwbasicMathsOperator "[<>+\*^/\\=-]"
syn match   gwbasicMathsOperator   "-\|=\|[:<>+\*^/\\]\|AND\|OR"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_basic_syntax_inits")
  if version < 508
    let did_basic_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink gwbasicLabel		Label
  HiLink gwbasicConditional	Conditional
  HiLink gwbasicRepeat		Repeat
  HiLink gwbasicLineNumber	Comment
  HiLink gwbasicNumber		Number
  HiLink gwbasicError		Error
  HiLink gwbasicStatement	Statement
  HiLink gwbasicString		String
  HiLink gwbasicComment		Comment
  HiLink gwbasicSpecial		Special
  HiLink gwbasicTodo		Todo
  HiLink gwbasicFunction		Identifier
  HiLink gwbasicTypeSpecifier Type
  HiLink gwbasicFilenumber basicTypeSpecifier
  "hi gwbasicMathsOperator term=bold cterm=bold gui=bold

  delcommand HiLink
endif

let b:current_syntax = "basic"

let &cpo = s:cpo_save
unlet s:cpo_save

" History
"
" 2016-10-30: Start from the source of the generic BASIC syntax file.
"
" 2016-12-14: Complete the list of keywords. Combine commands and functions.

" vim: ts=8

