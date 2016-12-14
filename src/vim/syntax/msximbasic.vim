" msximbasic.vim
" Vim syntax file
" Language:    MSX-imBASIC
" Author:      Marcos Cruz (programandala.net)
" License:     Vim license (GPL compatible)
" URL:         http://programandala.net/en.program.msx-imbasic.html
" Updated:     2016-11-01

" -------------------------------------------------------------
" Change history: see at the end of the file

" -------------------------------------------------------------
" To-do

" Finish the colors

" Test everything.

" Fix: the code commented out is highlighted as metacomments when tabs are
" used for indentation.

" 2014-08-08: Fix: label definitions group.

" 2014-12-13: Why PreProc keywords are highighted only at the start of the
" line?

" -------------------------------------------------------------

" For Vim version 5.x: Clear all syntax items
" For Vim version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version > 600
  setlocal iskeyword=48-57,65-90,97-122,$,#,_
else
  set iskeyword=48-57,65-90,97-122,$,#,_
endif

syn case ignore

" -------------------------------------------------------------
" Directives

syn keyword msximbasicPreProc #define
syn keyword msximbasicPreProc #endif
syn keyword msximbasicPreProc #else
syn keyword msximbasicPreProc #filename
syn keyword msximbasicPreProc #ifdef
syn keyword msximbasicPreProc #ifndef
syn keyword msximbasicPreProc #include
syn keyword msximbasicPreProc #previm
syn keyword msximbasicPreProc #procedurecall
syn keyword msximbasicPreProc #renumline
syn keyword msximbasicPreProc #run
syn keyword msximbasicPreProc #vim

" -------------------------------------------------------------
" Keywords

syn keyword msximbasicKeyword ABS
syn keyword msximbasicKeyword ACS
syn keyword msximbasicKeyword ADJUST
syn keyword msximbasicKeyword AND
syn keyword msximbasicKeyword ASC
syn keyword msximbasicKeyword ASN
syn keyword msximbasicKeyword ATN
syn keyword msximbasicKeyword ATTR$
syn keyword msximbasicKeyword AUTO
syn keyword msximbasicKeyword BASE
syn keyword msximbasicKeyword BEEP
syn keyword msximbasicKeyword BIN$
syn keyword msximbasicKeyword BLOAD
syn keyword msximbasicKeyword BORDER
syn keyword msximbasicKeyword BSAVE
syn keyword msximbasicKeyword CALL
syn keyword msximbasicKeyword CDBL
syn keyword msximbasicKeyword CHR$
syn keyword msximbasicKeyword CINT
syn keyword msximbasicKeyword CIRCLE
syn keyword msximbasicKeyword CLEAR
syn keyword msximbasicKeyword CLOAD
syn keyword msximbasicKeyword CLOSE
syn keyword msximbasicKeyword CLS
syn keyword msximbasicKeyword CMD
syn keyword msximbasicKeyword COLOR
syn keyword msximbasicKeyword CONT
syn keyword msximbasicKeyword COPY
syn keyword msximbasicKeyword COS
syn keyword msximbasicKeyword CRSLIN
syn keyword msximbasicKeyword CSAVE
syn keyword msximbasicKeyword CSNG
syn keyword msximbasicKeyword CVD
syn keyword msximbasicKeyword CVI
syn keyword msximbasicKeyword CVS
syn keyword msximbasicKeyword DATA
syn keyword msximbasicKeyword DEF
syn keyword msximbasicKeyword DEFDBL
syn keyword msximbasicKeyword DEFFN
syn keyword msximbasicKeyword DEFINT
syn keyword msximbasicKeyword DEFSNG
syn keyword msximbasicKeyword DEFSTR
syn keyword msximbasicKeyword DELETE
syn keyword msximbasicKeyword DIM
syn keyword msximbasicKeyword DO
syn keyword msximbasicKeyword DRAW
syn keyword msximbasicKeyword DSKF
syn keyword msximbasicKeyword DSKI$
syn keyword msximbasicKeyword DSKO$
syn keyword msximbasicKeyword ELSE
syn keyword msximbasicKeyword ELSEIF
syn keyword msximbasicKeyword END
syn keyword msximbasicKeyword ENDIF
syn keyword msximbasicKeyword EOF
syn keyword msximbasicKeyword EQU
syn keyword msximbasicKeyword EQV
syn keyword msximbasicKeyword ERASE
syn keyword msximbasicKeyword ERL
syn keyword msximbasicKeyword ERR
syn keyword msximbasicKeyword ERROR
syn keyword msximbasicKeyword EXIT
syn keyword msximbasicKeyword EXP
syn keyword msximbasicKeyword FIELD
syn keyword msximbasicKeyword FILES
syn keyword msximbasicKeyword FIX
syn keyword msximbasicKeyword FN
syn keyword msximbasicKeyword FOR
syn keyword msximbasicKeyword FORMAT
syn keyword msximbasicKeyword FPOS
syn keyword msximbasicKeyword FRE
syn keyword msximbasicKeyword GET
syn keyword msximbasicKeyword GOSUB
syn keyword msximbasicKeyword GOTO
syn keyword msximbasicKeyword HEX$
syn keyword msximbasicKeyword IF
syn keyword msximbasicKeyword IMP
syn keyword msximbasicKeyword IN
syn keyword msximbasicKeyword INKEY$
syn keyword msximbasicKeyword INP
syn keyword msximbasicKeyword INPUT
syn keyword msximbasicKeyword INPUT$
syn keyword msximbasicKeyword INSTR
syn keyword msximbasicKeyword INT
syn keyword msximbasicKeyword IPL
syn keyword msximbasicKeyword KEY
syn keyword msximbasicKeyword KILL
syn keyword msximbasicKeyword LABEL
syn keyword msximbasicKeyword LDF
syn keyword msximbasicKeyword LEFT$
syn keyword msximbasicKeyword LEN
syn keyword msximbasicKeyword LET
syn keyword msximbasicKeyword LFILES
syn keyword msximbasicKeyword LINE
syn keyword msximbasicKeyword LIST
syn keyword msximbasicKeyword LLIST
syn keyword msximbasicKeyword LN
syn keyword msximbasicKeyword LOAD
syn keyword msximbasicKeyword LOC
syn keyword msximbasicKeyword LOCATE
syn keyword msximbasicKeyword LOG
syn keyword msximbasicKeyword LOOP
syn keyword msximbasicKeyword LPOS
syn keyword msximbasicKeyword LPRINT
syn keyword msximbasicKeyword LSET
syn keyword msximbasicKeyword MAX
syn keyword msximbasicKeyword MAXFILES
syn keyword msximbasicKeyword MEMINI
syn keyword msximbasicKeyword MERGE
syn keyword msximbasicKeyword MFILES
syn keyword msximbasicKeyword MID$
syn keyword msximbasicKeyword MKD$
syn keyword msximbasicKeyword MKI$
syn keyword msximbasicKeyword MKILL
syn keyword msximbasicKeyword MKS$
syn keyword msximbasicKeyword MNAME
syn keyword msximbasicKeyword MOD
syn keyword msximbasicKeyword MOTOR
syn keyword msximbasicKeyword NAME
syn keyword msximbasicKeyword NEW
syn keyword msximbasicKeyword NEXT
syn keyword msximbasicKeyword NOT
syn keyword msximbasicKeyword OCT$
syn keyword msximbasicKeyword OFF
syn keyword msximbasicKeyword ON
syn keyword msximbasicKeyword OPEN
syn keyword msximbasicKeyword OR
syn keyword msximbasicKeyword OUT
syn keyword msximbasicKeyword OVER
syn keyword msximbasicKeyword PAD
syn keyword msximbasicKeyword PAINT
syn keyword msximbasicKeyword PASSWORD
syn keyword msximbasicKeyword PDL
syn keyword msximbasicKeyword PEEK
syn keyword msximbasicKeyword PI
syn keyword msximbasicKeyword PLAY
syn keyword msximbasicKeyword POINT
syn keyword msximbasicKeyword POKE
syn keyword msximbasicKeyword POS
syn keyword msximbasicKeyword PRESET
syn keyword msximbasicKeyword PRINT
syn keyword msximbasicKeyword PROC
syn keyword msximbasicKeyword PROC
syn keyword msximbasicKeyword PROMPT
syn keyword msximbasicKeyword PSET
syn keyword msximbasicKeyword PUT
syn keyword msximbasicKeyword READ
syn keyword msximbasicKeyword RENUM
syn keyword msximbasicKeyword RESTORE
syn keyword msximbasicKeyword RESUME
syn keyword msximbasicKeyword RETURN
syn keyword msximbasicKeyword RIGHT$
syn keyword msximbasicKeyword RND
syn keyword msximbasicKeyword RSET
syn keyword msximbasicKeyword RUN
syn keyword msximbasicKeyword SAVE
syn keyword msximbasicKeyword SCREEN
syn keyword msximbasicKeyword SET
syn keyword msximbasicKeyword SGN
syn keyword msximbasicKeyword SIN
syn keyword msximbasicKeyword SOUND
syn keyword msximbasicKeyword SPACE$
syn keyword msximbasicKeyword SPC
syn keyword msximbasicKeyword SPRITE
syn keyword msximbasicKeyword SPRITE$
syn keyword msximbasicKeyword SQR
syn keyword msximbasicKeyword STEP
syn keyword msximbasicKeyword STICK
syn keyword msximbasicKeyword STOP
syn keyword msximbasicKeyword STR$
syn keyword msximbasicKeyword STRIG
syn keyword msximbasicKeyword STRING$
syn keyword msximbasicKeyword SWAP
syn keyword msximbasicKeyword SYSTEM
syn keyword msximbasicKeyword TAB
syn keyword msximbasicKeyword TAN
syn keyword msximbasicKeyword THEN
syn keyword msximbasicKeyword TIME
syn keyword msximbasicKeyword TITLE
syn keyword msximbasicKeyword TO
syn keyword msximbasicKeyword TROFF
syn keyword msximbasicKeyword TRON
syn keyword msximbasicKeyword UNTIL
syn keyword msximbasicKeyword USING
syn keyword msximbasicKeyword USR
syn keyword msximbasicKeyword VAL
syn keyword msximbasicKeyword VARPTR
syn keyword msximbasicKeyword VDP
syn keyword msximbasicKeyword VIDEO
syn keyword msximbasicKeyword VPEEK
syn keyword msximbasicKeyword VPOKE
syn keyword msximbasicKeyword WAIT
syn keyword msximbasicKeyword WHILE
syn keyword msximbasicKeyword WIDTH
syn keyword msximbasicKeyword XOR

" -------------------------------------------------------------
" Numbers

"integer number, or floating point number without a dot.
syn match  msximbasicNumber "\<\d\+\>"
"floating point number, with dot
syn match  msximbasicNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  msximbasicNumber "\.\d\+\>"
"hex number XXX TODO -- and also 0x notation
"syn match  msximbasicNumber "&[0-9a-f]\+\>"

" -------------------------------------------------------------
"  Strings

" String and Character constants
syn match msximbasicSpecial contained "\\\d\d\d\|\\."
"syn region msximbasicString start='"' skip='""' end='"' contains=msximbasicSpecial
syn region msximbasicString start='"' skip='""' end='"'

"syn match   msximbasicTypeSpecifier "[a-zA-Z0-9][\$]"ms=s+1
syn match   msximbasicMathsOperator "[<>+\*^/=-]\|>=\|=<\|<>]"

" -------------------------------------------------------------
" Comments

syn keyword msximbasicTodo contained XXX TODO FIXME INFORMER TMP
syn region msximbasicLineStartComment start="^\s*//\s" end="$" contains=msximbasicTodo
syn region  msximbasicComment start="\(^\|:\)\s*REM\>" end="$" contains=msximbasicTodo
syn region  msximbasicComment start="^\?s*\'" end="$" contains=msximbasicTodo
syn region msximbasicMetaComment start="^\s*#\s" end="$" contains=msximbasicTodo
syn match msximbasicLineEmptyComment "^\s*//\s*$"
syn region msximbasicLineEndComment start="\s\+//\s" end="$" contains=msximbasicTodo
syn region msximbasicBlockComment start="^\s*/\*" end="\*/" contains=msximbasicTodo 

" -------------------------------------------------------------
" Labels

syn match msximbasicLabel "^\s*@[a-zA-Z0-9_]\+\>"

" -------------------------------------------------------------

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

  HiLink msximbasicNumber Number
  HiLink msximbasicKeyword Statement
  HiLink msximbasicString String
  HiLink msximbasicComment Comment
  HiLink msximbasicBlockComment Comment
  HiLink msximbasicLineStartComment Comment
  HiLink msximbasicMetaComment Comment
  HiLink msximbasicLineEndComment Comment
  HiLink msximbasicLineEmptyComment Comment
  HiLink msximbasicSpecial Special
  HiLink msximbasicTodo Todo
"  HiLink msximbasicTypeSpecifier Type
"  hi msximbasicMathsOperator term=bold cterm=bold gui=bold
  HiLink msximbasicPreProc PreProc
  HiLink msximbasicLabel Label

  delcommand HiLink
endif

let b:current_syntax = "msximbasic"

" -------------------------------------------------------------
" Change history

" 2016-10-30: First version (based on vimclairbasic.vim, by the same author).
"
" 2016-11-01: Fix the tick comment of MSX-BASIC. Add `ENDIF` and `DEFFN`.

