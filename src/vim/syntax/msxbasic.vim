" Vim syntax file
" Language:		MSX-BASIC
" Maintainer:	Marcos Cruz (programandala.net)
" License:		Vim license (GPL compatible)
" URL:			http://programandala.net/
" Last Change:  2016-12-14

" Based on:

" Language:		BASIC
" Maintainer:	Allan Kelly <allan@fruitloaf.co.uk>
" Last Change:  2011 Dec 25 by Thilo Six


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

syn keyword msxbasicKeyword ABS
syn keyword msxbasicKeyword ABSOLUTE
syn keyword msxbasicKeyword ACS
syn keyword msxbasicKeyword ADJUST
syn keyword msxbasicKeyword AND
syn keyword msxbasicKeyword ASC
syn keyword msxbasicKeyword ASN
syn keyword msxbasicKeyword ATN
syn keyword msxbasicKeyword ATTR$
syn keyword msxbasicKeyword AUTO
syn keyword msxbasicKeyword BASE
syn keyword msxbasicKeyword BEEP
syn keyword msxbasicKeyword BIN$
syn keyword msxbasicKeyword BLOAD
syn keyword msxbasicKeyword BORDER
syn keyword msxbasicKeyword BSAVE
syn keyword msxbasicKeyword CALL
syn keyword msxbasicKeyword CASE
syn keyword msxbasicKeyword CDBL
syn keyword msxbasicKeyword CHAIN
syn keyword msxbasicKeyword CHDIR
syn keyword msxbasicKeyword CHR$
syn keyword msxbasicKeyword CINT
syn keyword msxbasicKeyword CIRCLE
syn keyword msxbasicKeyword CLEAR
syn keyword msxbasicKeyword CLNG
syn keyword msxbasicKeyword CLOAD
syn keyword msxbasicKeyword CLOSE
syn keyword msxbasicKeyword CLS
syn keyword msxbasicKeyword CMD
syn keyword msxbasicKeyword COLOR
syn keyword msxbasicKeyword COM
syn keyword msxbasicKeyword COMMAND$
syn keyword msxbasicKeyword COMMON
syn keyword msxbasicKeyword CONST
syn keyword msxbasicKeyword CONT
syn keyword msxbasicKeyword COPY
syn keyword msxbasicKeyword COS
syn keyword msxbasicKeyword CRSLIN
syn keyword msxbasicKeyword CSAVE
syn keyword msxbasicKeyword CSNG
syn keyword msxbasicKeyword CSRLIN
syn keyword msxbasicKeyword CVD
syn keyword msxbasicKeyword CVDMBF
syn keyword msxbasicKeyword CVI
syn keyword msxbasicKeyword CVL
syn keyword msxbasicKeyword CVS
syn keyword msxbasicKeyword CVSMBF
syn keyword msxbasicKeyword DATA
syn keyword msxbasicKeyword DATE$
syn keyword msxbasicKeyword DECLARE
syn keyword msxbasicKeyword DEF
syn keyword msxbasicKeyword DEFDBL
syn keyword msxbasicKeyword DEFFN
syn keyword msxbasicKeyword DEFINT
syn keyword msxbasicKeyword DEFLNG
syn keyword msxbasicKeyword DEFSNG
syn keyword msxbasicKeyword DEFSTR
syn keyword msxbasicKeyword DELETE
syn keyword msxbasicKeyword DIM
syn keyword msxbasicKeyword DO
syn keyword msxbasicKeyword DRAW
syn keyword msxbasicKeyword DSKF
syn keyword msxbasicKeyword DSKI$
syn keyword msxbasicKeyword DSKO$
syn keyword msxbasicKeyword ELSE
syn keyword msxbasicKeyword ELSEIF
syn keyword msxbasicKeyword END
syn keyword msxbasicKeyword ENDIF
syn keyword msxbasicKeyword ENVIRON
syn keyword msxbasicKeyword ENVIRON$
syn keyword msxbasicKeyword EOF
syn keyword msxbasicKeyword EQU
syn keyword msxbasicKeyword EQV
syn keyword msxbasicKeyword ERASE
syn keyword msxbasicKeyword ERDEV
syn keyword msxbasicKeyword ERDEV$
syn keyword msxbasicKeyword ERL
syn keyword msxbasicKeyword ERR
syn keyword msxbasicKeyword ERROR
syn keyword msxbasicKeyword EXIT
syn keyword msxbasicKeyword EXP
syn keyword msxbasicKeyword FIELD
syn keyword msxbasicKeyword FILEATTR
syn keyword msxbasicKeyword FILES
syn keyword msxbasicKeyword FIX
syn keyword msxbasicKeyword FN
syn keyword msxbasicKeyword FOR
syn keyword msxbasicKeyword FORMAT
syn keyword msxbasicKeyword FPOS
syn keyword msxbasicKeyword FRE
syn keyword msxbasicKeyword FREEFILE
syn keyword msxbasicKeyword FUNCTION
syn keyword msxbasicKeyword GET
syn keyword msxbasicKeyword GOSUB
syn keyword msxbasicKeyword GOTO
syn keyword msxbasicKeyword HEX$
syn keyword msxbasicKeyword IF
syn keyword msxbasicKeyword IMP
syn keyword msxbasicKeyword IN
syn keyword msxbasicKeyword INKEY$
syn keyword msxbasicKeyword INP
syn keyword msxbasicKeyword INPUT
syn keyword msxbasicKeyword INPUT$
syn keyword msxbasicKeyword INSTR
syn keyword msxbasicKeyword INT
syn keyword msxbasicKeyword IOCTL
syn keyword msxbasicKeyword IOCTL$
syn keyword msxbasicKeyword IPL
syn keyword msxbasicKeyword KEY
syn keyword msxbasicKeyword KILL
syn keyword msxbasicKeyword LABEL
syn keyword msxbasicKeyword LAFT$
syn keyword msxbasicKeyword LBOUND
syn keyword msxbasicKeyword LCASES$
syn keyword msxbasicKeyword LDF
syn keyword msxbasicKeyword LEFT$
syn keyword msxbasicKeyword LEN
syn keyword msxbasicKeyword LET
syn keyword msxbasicKeyword LFILES
syn keyword msxbasicKeyword LINE
syn keyword msxbasicKeyword LIST
syn keyword msxbasicKeyword LLIST
syn keyword msxbasicKeyword LN
syn keyword msxbasicKeyword LOAD
syn keyword msxbasicKeyword LOC
syn keyword msxbasicKeyword LOCATE
syn keyword msxbasicKeyword LOCK
syn keyword msxbasicKeyword LOF
syn keyword msxbasicKeyword LOG
syn keyword msxbasicKeyword LOOP
syn keyword msxbasicKeyword LPOS
syn keyword msxbasicKeyword LPRINT
syn keyword msxbasicKeyword LSET
syn keyword msxbasicKeyword LTRIM$
syn keyword msxbasicKeyword MAX
syn keyword msxbasicKeyword MAXFILES
syn keyword msxbasicKeyword MEMINI
syn keyword msxbasicKeyword MERGE
syn keyword msxbasicKeyword MFILES
syn keyword msxbasicKeyword MID$
syn keyword msxbasicKeyword MKD$
syn keyword msxbasicKeyword MKDIR
syn keyword msxbasicKeyword MKDMBF$
syn keyword msxbasicKeyword MKI$
syn keyword msxbasicKeyword MKILL
syn keyword msxbasicKeyword MKL$
syn keyword msxbasicKeyword MKS$
syn keyword msxbasicKeyword MKSMBF$
syn keyword msxbasicKeyword MNAME
syn keyword msxbasicKeyword MOD
syn keyword msxbasicKeyword MOTOR
syn keyword msxbasicKeyword NAME
syn keyword msxbasicKeyword NEW
syn keyword msxbasicKeyword NEXT
syn keyword msxbasicKeyword NOT
syn keyword msxbasicKeyword OCT$
syn keyword msxbasicKeyword OFF
syn keyword msxbasicKeyword ON
syn keyword msxbasicKeyword OPEN
syn keyword msxbasicKeyword OPTION
syn keyword msxbasicKeyword OR
syn keyword msxbasicKeyword OUT
syn keyword msxbasicKeyword OVER
syn keyword msxbasicKeyword PAD
syn keyword msxbasicKeyword PAINT
syn keyword msxbasicKeyword PALETTE
syn keyword msxbasicKeyword PASSWORD
syn keyword msxbasicKeyword PCOPY
syn keyword msxbasicKeyword PDL
syn keyword msxbasicKeyword PEEK
syn keyword msxbasicKeyword PEN
syn keyword msxbasicKeyword PI
syn keyword msxbasicKeyword PLAY
syn keyword msxbasicKeyword PMAP
syn keyword msxbasicKeyword POINT
syn keyword msxbasicKeyword POKE
syn keyword msxbasicKeyword POS
syn keyword msxbasicKeyword PRESET
syn keyword msxbasicKeyword PRINT
syn keyword msxbasicKeyword PROC
syn keyword msxbasicKeyword PROMPT
syn keyword msxbasicKeyword PSET
syn keyword msxbasicKeyword PUT
syn keyword msxbasicKeyword RANDOMIZE
syn keyword msxbasicKeyword READ
syn keyword msxbasicKeyword REDIM
syn keyword msxbasicKeyword RENUM
syn keyword msxbasicKeyword RESET
syn keyword msxbasicKeyword RESTORE
syn keyword msxbasicKeyword RESUME
syn keyword msxbasicKeyword RETURN
syn keyword msxbasicKeyword RIGHT$
syn keyword msxbasicKeyword RMDIR
syn keyword msxbasicKeyword RND
syn keyword msxbasicKeyword RSET
syn keyword msxbasicKeyword RTRIM$
syn keyword msxbasicKeyword RUN
syn keyword msxbasicKeyword SADD
syn keyword msxbasicKeyword SAVE
syn keyword msxbasicKeyword SCREEN
syn keyword msxbasicKeyword SEEK
syn keyword msxbasicKeyword SELECT
syn keyword msxbasicKeyword SET
syn keyword msxbasicKeyword SETMEM
syn keyword msxbasicKeyword SGN
syn keyword msxbasicKeyword SHARED
syn keyword msxbasicKeyword SHELL
syn keyword msxbasicKeyword SIN
syn keyword msxbasicKeyword SLEEP
syn keyword msxbasicKeyword SOUND
syn keyword msxbasicKeyword SPACE$
syn keyword msxbasicKeyword SPC
syn keyword msxbasicKeyword SPRITE
syn keyword msxbasicKeyword SPRITE$
syn keyword msxbasicKeyword SQR
syn keyword msxbasicKeyword STATIC
syn keyword msxbasicKeyword STEP
syn keyword msxbasicKeyword STICK
syn keyword msxbasicKeyword STOP
syn keyword msxbasicKeyword STR$
syn keyword msxbasicKeyword STRIG
syn keyword msxbasicKeyword STRING$
syn keyword msxbasicKeyword SUB
syn keyword msxbasicKeyword SWAP
syn keyword msxbasicKeyword SYSTEM
syn keyword msxbasicKeyword TAB
syn keyword msxbasicKeyword TAN
syn keyword msxbasicKeyword THEN
syn keyword msxbasicKeyword TIME
syn keyword msxbasicKeyword TIME$
syn keyword msxbasicKeyword TIMER
syn keyword msxbasicKeyword TITLE
syn keyword msxbasicKeyword TO
syn keyword msxbasicKeyword TROFF
syn keyword msxbasicKeyword TRON
syn keyword msxbasicKeyword TYPE
syn keyword msxbasicKeyword UBOUND
syn keyword msxbasicKeyword UCASE$
syn keyword msxbasicKeyword UNLOCK
syn keyword msxbasicKeyword UNTIL
syn keyword msxbasicKeyword USING
syn keyword msxbasicKeyword USR
syn keyword msxbasicKeyword VAL
syn keyword msxbasicKeyword VALPTR
syn keyword msxbasicKeyword VALSEG
syn keyword msxbasicKeyword VARPTR
syn keyword msxbasicKeyword VARPTR$
syn keyword msxbasicKeyword VARSEG
syn keyword msxbasicKeyword VDP
syn keyword msxbasicKeyword VIDEO
syn keyword msxbasicKeyword VIEW
syn keyword msxbasicKeyword VPEEK
syn keyword msxbasicKeyword VPOKE
syn keyword msxbasicKeyword WAIT
syn keyword msxbasicKeyword WEND
syn keyword msxbasicKeyword WHILE
syn keyword msxbasicKeyword WIDTH
syn keyword msxbasicKeyword WINDOW
syn keyword msxbasicKeyword WRITE
syn keyword msxbasicKeyword XOR

syn keyword msxbasicTodo contained	TODO

"integer number, or floating point number without a dot.
syn match  msxbasicNumber		"\<\d\+\>"
"floating point number, with dot
syn match  msxbasicNumber		"\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  msxbasicNumber		"\.\d\+\>"

" String and Character contstants
syn match   msxbasicSpecial contained "\\\d\d\d\|\\."
syn region  msxbasicString		  start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=basicSpecial

syn region  msxbasicComment	start="REM" end="$" contains=basicTodo
syn region  msxbasicComment	start="^[ \t]*'" end="$" contains=basicTodo
syn region  msxbasicLineNumber	start="^\d" end="\s"
syn match   msxbasicTypeSpecifier  "[a-zA-Z0-9][\$%&!#]"ms=s+1
" Used with OPEN statement
syn match   msxbasicFilenumber  "#\d\+"
"syn sync ccomment msxbasicComment
" syn match   msxbasicMathsOperator "[<>+\*^/\\=-]"
syn match   msxbasicMathsOperator   "-\|=\|[:<>+\*^/\\]\|AND\|OR"

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

  HiLink msxbasicLabel		Label
  HiLink msxbasicConditional	Conditional
  HiLink msxbasicRepeat		Repeat
  HiLink msxbasicLineNumber	Comment
  HiLink msxbasicNumber		Number
  HiLink msxbasicError		Error
  HiLink msxbasicStatement	Statement
  HiLink msxbasicString		String
  HiLink msxbasicComment		Comment
  HiLink msxbasicSpecial		Special
  HiLink msxbasicTodo		Todo
  HiLink msxbasicFunction		Identifier
  HiLink msxbasicTypeSpecifier Type
  HiLink msxbasicFilenumber basicTypeSpecifier
  "hi msxbasicMathsOperator term=bold cterm=bold gui=bold

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
