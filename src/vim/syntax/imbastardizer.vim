" imbastardizer.vim
" Vim syntax file
" Language:    Imbastardizer
" Author:      Marcos Cruz (programandala.net)
" License:     Vim license (GPL compatible)
" URL:         http://programandala.net/
" Updated:     2017-06-14

" See change log at the end of the file

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

syn keyword imbasPreProc #define
syn keyword imbasPreProc #endif
syn keyword imbasPreProc #else
syn keyword imbasPreProc #filename
syn keyword imbasPreProc #ifdef
syn keyword imbasPreProc #ifndef
syn keyword imbasPreProc #iftarget
syn keyword imbasPreProc #include
syn keyword imbasPreProc #previm
syn keyword imbasPreProc #procedurecall
syn keyword imbasPreProc #renumline
syn keyword imbasPreProc #run
syn keyword imbasPreProc #target
syn keyword imbasPreProc #vim

" -------------------------------------------------------------
" Keywords

" XXX TODO -- make this depend on the target dialect

syn keyword imbasKeyword ABS
syn keyword imbasKeyword AND
syn keyword imbasKeyword ACS
syn keyword imbasKeyword ADJUST
syn keyword imbasKeyword AND
syn keyword imbasKeyword ASC
syn keyword imbasKeyword ASN
syn keyword imbasKeyword ATN
syn keyword imbasKeyword ATTR$
syn keyword imbasKeyword AUTO
syn keyword imbasKeyword BASE
syn keyword imbasKeyword BEEP
syn keyword imbasKeyword BIN$
syn keyword imbasKeyword BLOAD
syn keyword imbasKeyword BORDER
syn keyword imbasKeyword BSAVE
syn keyword imbasKeyword CALL
syn keyword imbasKeyword CDBL
syn keyword imbasKeyword CHR$
syn keyword imbasKeyword CINT
syn keyword imbasKeyword CIRCLE
syn keyword imbasKeyword CLEAR
syn keyword imbasKeyword CLOAD
syn keyword imbasKeyword CLOSE
syn keyword imbasKeyword CLS
syn keyword imbasKeyword CMD
syn keyword imbasKeyword COLOR
syn keyword imbasKeyword CONT
syn keyword imbasKeyword COPY
syn keyword imbasKeyword COS
syn keyword imbasKeyword CSRLIN
syn keyword imbasKeyword CSAVE
syn keyword imbasKeyword CSNG
syn keyword imbasKeyword CVD
syn keyword imbasKeyword CVI
syn keyword imbasKeyword CVS
syn keyword imbasKeyword DATA
syn keyword imbasKeyword DEF
syn keyword imbasKeyword DEFDBL
syn keyword imbasKeyword DEFFN
syn keyword imbasKeyword DEFINT
syn keyword imbasKeyword DEFSNG
syn keyword imbasKeyword DEFSTR
syn keyword imbasKeyword DELETE
syn keyword imbasKeyword DIM
syn keyword imbasKeyword DO
syn keyword imbasKeyword DRAW
syn keyword imbasKeyword DSKF
syn keyword imbasKeyword DSKI$
syn keyword imbasKeyword DSKO$
syn keyword imbasKeyword ELSE
syn keyword imbasKeyword ELSEIF
syn keyword imbasKeyword END
syn keyword imbasKeyword ENDIF
syn keyword imbasKeyword EOF
syn keyword imbasKeyword EQU
syn keyword imbasKeyword EQV
syn keyword imbasKeyword ERASE
syn keyword imbasKeyword ERL
syn keyword imbasKeyword ERR
syn keyword imbasKeyword ERROR
syn keyword imbasKeyword EXIT
syn keyword imbasKeyword EXP
syn keyword imbasKeyword FIELD
syn keyword imbasKeyword FILES
syn keyword imbasKeyword FIX
syn keyword imbasKeyword FN
syn keyword imbasKeyword FOR
syn keyword imbasKeyword FORMAT
syn keyword imbasKeyword FPOS
syn keyword imbasKeyword FRE
syn keyword imbasKeyword GET
syn keyword imbasKeyword GOSUB
syn keyword imbasKeyword GOTO
syn keyword imbasKeyword HEX$
syn keyword imbasKeyword IF
syn keyword imbasKeyword IMP
syn keyword imbasKeyword IN
syn keyword imbasKeyword INKEY$
syn keyword imbasKeyword INP
syn keyword imbasKeyword INPUT
syn keyword imbasKeyword INPUT$
syn keyword imbasKeyword INSTR
syn keyword imbasKeyword INT
syn keyword imbasKeyword IPL
syn keyword imbasKeyword KEY
syn keyword imbasKeyword KILL
syn keyword imbasKeyword LABEL
syn keyword imbasKeyword LDF
syn keyword imbasKeyword LEFT$
syn keyword imbasKeyword LEN
syn keyword imbasKeyword LET
syn keyword imbasKeyword LFILES
syn keyword imbasKeyword LINE
syn keyword imbasKeyword LIST
syn keyword imbasKeyword LLIST
syn keyword imbasKeyword LN
syn keyword imbasKeyword LOAD
syn keyword imbasKeyword LOC
syn keyword imbasKeyword LOCATE
syn keyword imbasKeyword LOG
syn keyword imbasKeyword LOOP
syn keyword imbasKeyword LPOS
syn keyword imbasKeyword LPRINT
syn keyword imbasKeyword LSET
syn keyword imbasKeyword MAX
syn keyword imbasKeyword MAXFILES
syn keyword imbasKeyword MEMINI
syn keyword imbasKeyword MERGE
syn keyword imbasKeyword MFILES
syn keyword imbasKeyword MID$
syn keyword imbasKeyword MKD$
syn keyword imbasKeyword MKI$
syn keyword imbasKeyword MKILL
syn keyword imbasKeyword MKS$
syn keyword imbasKeyword MNAME
syn keyword imbasKeyword MOD
syn keyword imbasKeyword MOTOR
syn keyword imbasKeyword NAME
syn keyword imbasKeyword NEW
syn keyword imbasKeyword NEXT
syn keyword imbasKeyword NOT
syn keyword imbasKeyword OCT$
syn keyword imbasKeyword OFF
syn keyword imbasKeyword ON
syn keyword imbasKeyword OPEN
syn keyword imbasKeyword OPTION
syn keyword imbasKeyword OR
syn keyword imbasKeyword OUT
syn keyword imbasKeyword OVER
syn keyword imbasKeyword PAD
syn keyword imbasKeyword PAINT
syn keyword imbasKeyword PASSWORD
syn keyword imbasKeyword PDL
syn keyword imbasKeyword PEEK
syn keyword imbasKeyword PI
syn keyword imbasKeyword PLAY
syn keyword imbasKeyword POINT
syn keyword imbasKeyword POKE
syn keyword imbasKeyword POS
syn keyword imbasKeyword PRESET
syn keyword imbasKeyword PRINT
syn keyword imbasKeyword PROC
syn keyword imbasKeyword PROC
syn keyword imbasKeyword PROMPT
syn keyword imbasKeyword PSET
syn keyword imbasKeyword PUT
syn keyword imbasKeyword READ
syn keyword imbasKeyword RENUM
syn keyword imbasKeyword RESTORE
syn keyword imbasKeyword RESUME
syn keyword imbasKeyword RETURN
syn keyword imbasKeyword RIGHT$
syn keyword imbasKeyword RND
syn keyword imbasKeyword RSET
syn keyword imbasKeyword RUN
syn keyword imbasKeyword SAVE
syn keyword imbasKeyword SCREEN
syn keyword imbasKeyword SET
syn keyword imbasKeyword SGN
syn keyword imbasKeyword SIN
syn keyword imbasKeyword SOUND
syn keyword imbasKeyword SPACE$
syn keyword imbasKeyword SPC
syn keyword imbasKeyword SPRITE
syn keyword imbasKeyword SPRITE$
syn keyword imbasKeyword SQR
syn keyword imbasKeyword STEP
syn keyword imbasKeyword STICK
syn keyword imbasKeyword STOP
syn keyword imbasKeyword STR$
syn keyword imbasKeyword STRIG
syn keyword imbasKeyword STRING$
syn keyword imbasKeyword SWAP
syn keyword imbasKeyword SYSTEM
syn keyword imbasKeyword TAB
syn keyword imbasKeyword TAN
syn keyword imbasKeyword THEN
syn keyword imbasKeyword TIME
syn keyword imbasKeyword TITLE
syn keyword imbasKeyword TO
syn keyword imbasKeyword TROFF
syn keyword imbasKeyword TRON
syn keyword imbasKeyword UNTIL
syn keyword imbasKeyword USING
syn keyword imbasKeyword USR
syn keyword imbasKeyword VAL
syn keyword imbasKeyword VARPTR
syn keyword imbasKeyword VDP
syn keyword imbasKeyword VIDEO
syn keyword imbasKeyword VPEEK
syn keyword imbasKeyword VPOKE
syn keyword imbasKeyword WAIT
syn keyword imbasKeyword WHILE
syn keyword imbasKeyword WIDTH
syn keyword imbasKeyword XOR

" -------------------------------------------------------------
" Numbers

"integer number, or floating point number without a dot.
syn match  imbasNumber "\<\d\+\>"
"floating point number, with dot
syn match  imbasNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  imbasNumber "\.\d\+\>"
"hex number XXX TODO -- and also 0x notation
"syn match  imbasNumber "&[0-9a-f]\+\>"

" -------------------------------------------------------------
"  Strings

" String and Character constants
syn match imbasSpecial contained "\\\d\d\d\|\\."
"syn region imbasString start='"' skip='""' end='"' contains=imbasSpecial
syn region imbasString start='"' skip='""' end='"'

"syn match   imbasTypeSpecifier "[a-zA-Z0-9][\$]"ms=s+1
syn match   imbasMathsOperator "[<>+\*^/=-]\|>=\|=<\|<>]"

" -------------------------------------------------------------
" Comments

syn keyword imbasTodo contained XXX TODO FIXME INFORMER TMP
syn region imbasLineStartComment start="^\s*//\s" end="$" contains=imbasTodo
syn region  imbasComment start="\(^\|:\)\s*REM\>" end="$" contains=imbasTodo
syn region  imbasComment start="^\?s*\'" end="$" contains=imbasTodo
syn region imbasMetaComment start="^\s*#\s" end="$" contains=imbasTodo
syn match imbasLineEmptyComment "^\s*//\s*$"
syn region imbasLineEndComment start="\s\+//\s" end="$" contains=imbasTodo
syn region imbasBlockComment start="^\s*/\*" end="\*/" contains=imbasTodo 

" -------------------------------------------------------------
" Labels

syn match imbasLabel "^\s*@[a-zA-Z0-9_]\+\>"

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

  HiLink imbasNumber Number
  HiLink imbasKeyword Statement
  HiLink imbasString String
  HiLink imbasComment Comment
  HiLink imbasBlockComment Comment
  HiLink imbasLineStartComment Comment
  HiLink imbasMetaComment Comment
  HiLink imbasLineEndComment Comment
  HiLink imbasLineEmptyComment Comment
  HiLink imbasSpecial Special
  HiLink imbasTodo Todo
"  HiLink imbasTypeSpecifier Type
"  hi imbasMathsOperator term=bold cterm=bold gui=bold
  HiLink imbasPreProc PreProc
  HiLink imbasLabel Label

  delcommand HiLink
endif

let b:current_syntax = "imbastardizer"

" -------------------------------------------------------------
" Change log

" 2016-12-14: First version (based on vimclairbasic.vim and imbas, by the same author).
"
" 2016-12-28: Fix `csrlin`.
"
" 2017-06-05: Add `and`, `option`.
"
" 2017-06-13: Add `#iftarget`.
"
" 2017-06-14: Add `#target`.
