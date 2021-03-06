" imbastardizer.vim

" This file is part of Imbastardizer
" http://programandala.net/en.program.imbastardizer.html

" Copyright (C) 2016,2017 Marcos Cruz (programandala.net)

" You may do whatever you want with this work, so long as you retain
" the copyright/authorship/acknowledgment/credit notice(s) and this
" license in all redistributed copies and derived works.  There is no
" warranty.

" Last modified 201706161214

runtime imbastardizer_version.vim

" ----------------------------------------------

let b:enum=0

function! Enum(...)

  " Return the current value of 'b:enum' and increase it.
  " If a parameter is given, store it into 'b:enum' first.
  "
  " This function is provided to enumerate constant values in `#vim`
  " directives.
  "
  " Usage example:
  "
  "

  if a:0 " Any parameter?
    let b:enum=a:1 " Use the first parameter
  endif
  let l:output=b:enum
  let b:enum=b:enum+1
  return l:output

endfunction

function! Clean()

  " Clean the source code.

  " Save the '#vim' directives XXX OLD
"  let l:mark='vimcommand'.localtime()
"  execute 'silent! %s/^\s*#vim\>/'.l:mark.'/ei'

  " Remove the metacomments
  silent! %s/^\s*#\(\s.*\)\?$//e

  " Restore the '#vim' directives XXX OLD
"  execute 'silent! %s/^'.l:mark.'/#vim/e'

  silent! %s/\s*\/\/.*$//e " Remove the // line comments
  silent! %s,^\s*\/\*\_.\{-}\*\/,,e " Remove the /* */ block comments
  silent! %s/^\s\+//e " Remove indentation
  silent! %s/\s\+$//e " Remove trailing spaces
  silent! %s/^\n//e " Remove the empty lines
  silent! %s/\\\n//e " Join the splitted lines

  echo 'Source code cleaned'

  call SaveStep('clean')

endfunction

" ----------------------------------------------
" Control structures

function! ControlStructures()

  call DoLoop()
  call ExitFor()
  call IfEndif()

endfunction

function! DoLoop()

  " Convert all 'DO LOOP' structures.

  " The  BASIC 'DO LOOP' structures are copied from Andy Wright's Beta
  " BASIC, SAM BASIC and MasterBASIC: they allow 'UNTIL' and 'WHILE' in any
  " combination (there are nine possible combinations).

  let s:doStatement=''

  "echo '  XXX About to search for a DO!'
  call cursor(1,1)
  while search('^do\(\s\+\(until\|while\)\s\+.\+\)\?$','Wc')
    " first DO found
    "echo '  XXX DO found!'
    let s:doLineNumber=line('.') " line number of the DO statement
    call Do()
    let l:unclosedLoops=1 " counter
    while search('^\(do\|loop\)\>','W')
      " DO or LOOP found
      "echo '  XXX DO or LOOP found'
      "echo '  XXX line: '.getline('.')
      if strpart(getline('.'),0,2)=='do'
        " DO
        let l:unclosedLoops=l:unclosedLoops+1
      else
        " LOOP
        let l:unclosedLoops=l:unclosedLoops-1
        if l:unclosedLoops==0
          call Loop()
          break
        endif
      endif
    endwhile
    if l:unclosedLoops
      echoerr 'DO without LOOP at line '.s:doLineNumber
    endif
    call cursor(s:doLineNumber,'$')
  endwhile

  call ExitDo()

  call SaveStep('do_loop')

endfunction

function! Do()

  " Open a 'DO LOOP' structure.

  " Syntax:

  " 'DO' and 'LOOP' (with optional 'UNTIL' or 'WHILE' condition) must be the
  " only statements on their lines.

  " How this works:

  " The loop start can be 'DO', 'DO UNTIL' or 'DO WHILE'.  If it's just 'DO',
  " a label is enough.  If it's 'DO UNTIL' or 'DO WHILE', a conditional jump
  " has to be inserted, but the destination line is unknown until the
  " correspondent 'LOOP' is found.  Therefore the code is stored into
  " 's:doStatement' in order to create it later ('Loop()' does it),
  " with the line number added.

  " Save the original line:
  let l:doLine=getline('.')

  " Put a label instead:
  call setline('.','@do'.s:doLineNumber)

  " Check the kind of 'DO' and calculate the proper statement:
  " Note: '\c' at the start of the patterns ignores case.
  if match(l:doLine,'\c^do\s\+while\>')>-1
    let l:conditionPos=matchend(l:doLine,'^do\s\+while\s\+')
    let l:condition=strpart(l:doLine,l:conditionPos)
    let s:doStatement='if not ('.l:condition.') then goto '
  elseif match(l:doLine,'\c^do\s\+until\>')>-1
    let l:conditionPos=matchend(l:doLine,'^do\s\+until\s\+')
    let l:condition=strpart(l:doLine,l:conditionPos)
    let s:doStatement='if '.l:condition.' then goto '
  elseif match(l:doLine,'\c^do$')>-1
    let s:doStatement=''
  else
    echoerr 'DO bad syntax at line '.line('.')
  endif

endfunction

function! Loop()

  " Close a 'DO LOOP' structure.

  let l:loopLine=getline('.')
  let l:jump='goto @do'.s:doLineNumber
  "echo '  XXX--- Right LOOP: '.l:loopLine
  if match(l:loopLine,'^loop\s\+while\>')>-1
    execute 'substitute,^loop\s\+while\s\+\(.\+\)$,if \1 then '.l:jump.',i'
  elseif match(l:loopLine,'^loop\s\+until\>')>-1
    execute 'substitute,^loop\s\+until\s\+\(.\+\)$,if not (\1) then '.l:jump.',i'
    " XXX TODO -- use `not(x)` or `(x)=0` depending on the target; use `function! Not()`.
  elseif match(l:loopLine,'^loop$')>-1
    execute 'substitute,^loop$,'.l:jump.',i'
  else
    echoerr 'LOOP bad syntax at line '.line('.')
  endif

  " Create a label after the end of the loop
  " (it may be needed by 'DO WHILE', 'DO UNTIL' or 'EXIT DO'):
  let l:loopExitLabel='@loopExit'.s:doLineNumber
  call append(line('.'),l:loopExitLabel)

  " Finish the 'DO' if necessary:
  if s:doStatement!=''
    " Complete and create the jump to the 'DO':
    call append(s:doLineNumber,s:doStatement.l:loopExitLabel)
    let s:doStatement=''
  endif

endfunction

function! ExitDo()

  " Convert 'EXIT DO'.

  " 'EXIT DO' must be at the end of a line.
  " The form 'EXITDO' is allowed.

  let s:doStatement=''

  "echo '  XXX About to search for an EXIT DO!'
  call cursor(1,1)
  while search('\<exit\s\?do$','Wc')
    "echo '  XXX EXIT DO found!'
    let l:exitDoLineNumber=line('.')
    if search('^@loopExit\d\+$','W')
      let l:exitLabel=getline('.')
      call cursor(l:exitDoLineNumber,'^')
      execute 'silent! substitute,\<exit\s\?do\>,goto '.l:exitLabel.',ei'
    else
      echoerr 'EXIT DO without LOOP at line '.exitDoLineNumber
    endif
  endwhile

endfunction

function! ExitFor()

  " Convert 'EXIT FOR'.

  " 'EXIT FOR' and its correspondent 'NEXT' must be at the end of the line.
  " The form 'EXITFOR' is allowed.

  let s:doStatement=''

  if s:target=='pcbasic'
    let l:nextPattern='\<next [a-z]\+[%!#]\?\>'
  elseif s:target=='gwbasic'
    let l:nextPattern='\<next [a-z]\+[%!#]\?\>'
  elseif s:target=='msxbasic'
    let l:nextPattern='\<next [a-z]\+[%!#]\?\>'
  elseif s:target=="zxspectrumbasic"
    let l:nextPattern='\<next [a-z]\>'
  endif

  call cursor(1,1)
  while search('\<exit\s\?for$','Wc')
    "echo '  XXX EXIT FOR found at line '.line('.').': '.getline('.')
    let l:exitForLineNumber=line('.')
    if search(l:nextPattern,'W')
      "echo '  XXX NEXT found at line '.line('.').': '.getline('.')
      let l:exitLabel='@forExit'.line('.')
      call append(line('.'),l:exitLabel)
      call cursor(l:exitForLineNumber,'^')
      execute 'silent! substitute,\<exit\s\?for\>,goto '.l:exitLabel.',ei'
    else
      echoerr 'EXIT FOR without NEXT at line '.exitForLineNumber
    endif
  endwhile

  call SaveStep('exit_for')

endfunction

function! IfEndif()

  " Convert all 'IF ENDIF' structures.

  " XXX TODO finish -- adapt to BASIC dialects that provide `ELSE`

  " The Imbastardizer's 'IF ENDIF' structures are inspired by Andy Wright's
  " Beta BASIC, SAM BASIC and MasterBASIC, but they are not identical.

  " Syntax:

  " Short 'IF' structures:

  "   IF condition THEN action

  " Of course they can be splitted into any number of text lines:

  "   IF condition THEN \
  "     action

  " As usual, the splitting format does not affect the parsing, as long as the
  " required spaces are preserved before the splitting points:

  "   IF \
  "     condition \
  "   THEN \
  "     action

  " Long 'IF' structures must have 'THEN' after every condition; 'IF' and
  " 'ELSE IF' must be at the start of the line; 'ELSEIF' is allowed; 'ELSE'
  " must be on its own line:

  "   IF condition1 THEN
  "     code1
  "   ELSE IF condition2 THEN
  "     code2
  "   ELSE
  "     code3
  "   ENDIF

  " 'END IF' can be used instead of 'ENDIF'.

  "echo '  XXX About to search for a long IF!'
  call cursor(1,1)
  while search('^if .\+ then$','Wc')

    " Main long 'IF' found
"    echo 'XXX IF found'
"    echo '<'.getline('.').'>'
    let l:ifLineNumber=line('.')
    let l:endifLabel='@endif'.l:ifLineNumber
    let l:conditionLineNumber=line('.')
    let l:condition=substitute(getline('.'), '^if\s\+\(.\{-}\)\s\+then$', '\1', '')
    let l:unclosedConditionals=1 " counter
    let l:elseLineNumber=0 " used also as a flag

    while search('^\(\(else\s\?\)\?if\s\+.\+\s\+then\|else\|end\s\?if\)$','W')
      " Nested long 'IF', 'ELSE IF', 'ELSE' or 'ENDIF' found
"      echo '  XXX IF, ELSE IF, ELSE or ENDIF found'
"      echo '  <'.getline('.').'>'
      if strpart(getline('.'),0,2)=='if'
        " Nested long IF
        let l:unclosedConditionals=l:unclosedConditionals+1
      elseif match(getline('.'),'else\s\?if')==0
        " ELSE IF
"        echo '  XXX ELSE IF found'
"        echo '  <'.getline('.').'>'
        if l:unclosedConditionals==1 " current IF structure?
          if l:elseLineNumber " there was a previous ELSE?
            echoerr 'ELSE IF after ELSE at line '.line('.')
            break
          else
            call append(line('.')-1,'goto '.l:endifLabel)
            " Make the previous condition jump here when false:
            let l:elseIfLabel='@elseIf'.l:ifLineNumber.'_'.line('.')
            let l:newIf='if '.Not(l:condition).' then goto '.l:elseIfLabel
            call setline(l:conditionLineNumber,l:newIf)
            call append(line('.')-1,l:elseIfLabel)
            " Keep the current condition:
            let l:conditionLineNumber=line('.')
            let l:condition=substitute(getline('.'), '^else\s\?if\s*\(.\{-}\)\s*then$', '\1', '')
            "
          endif
        endif
      elseif getline('.')=='else'
        " ELSE
"        echo '  XXX ELSE found'
"        echo '  <'.getline('.').'>'
        if l:unclosedConditionals==1 " current IF structure?
          if l:elseLineNumber " there was a previous ELSE?
            echoerr 'Second ELSE at line '.line('.')
            break
          else
            call append(line('.')-1,'goto '.l:endifLabel)
            let l:elseLineNumber=line('.')
            " Make the previous condition jump here when false:
            let l:elseLabel='@else'.l:ifLineNumber
            let l:newIf='if '.Not(l:condition).' then goto '.l:elseLabel
            call setline(l:conditionLineNumber,l:newIf)
            call setline('.',l:elseLabel)
            " Keep the current condition:
            let l:conditionLineNumber=line('.') " XXX needed?
            let l:condition=''
          endif
        endif
      else
        " ENDIF
"        echo '  XXX ENDIF found'
"        echo '  <'.getline('.').'>'
        let l:unclosedConditionals=l:unclosedConditionals-1
        if l:unclosedConditionals==0 " current IF structure?
          call setline('.',l:endifLabel)
          if len(l:condition) " is there an unresolved condition?
            let l:newIf='if '.Not(l:condition).' then goto '.l:endifLabel
            call setline(l:conditionLineNumber,l:newIf)
          endif
          break
        endif
      endif
    endwhile

    if l:unclosedConditionals
      echoerr 'IF without ENDIF at line '.l:ifLineNumber
    endif

    call cursor(l:ifLineNumber,'$')
  endwhile

  call SaveStep('if_endif')

endfunction

function! Not(expression)

  " Return the opposite of the given expression.
  " If the expression already has a 'NOT' at the start, just remove it;
  " otherwise, add a 'NOT' to it.

  let l:expression=a:expression
  let l:expression=substitute(l:expression,'^\s*\(.\{-}\)\s*$','\1','')
  " XXX Somehow, '\>' does not work in the following pattern, so
  " '[ (]' is used instead:
  if match(l:expression,'=0$')==(len(l:expression)-2)
    let l:expression=strpart(l:expression,0,len(l:expression)-2)
    let l:expression=WithoutParens(l:expression)
  else
    let l:expression=l:expression.'=0'
  endif
  return l:expression

endfunction

function! WithoutParens(expression)

  " Remove the outside parens from the given expression.

  let l:expression=a:expression
  " XXX TODO improve the expression (use just one match() instead, if possible)
  while match(l:expression,'(')==0 && strpart(l:expression,len(l:expression)-1)==')'
    let l:expression=substitute(l:expression,'^(\s*\(\{-}\)\s*)$','\1','')
  endwhile
  return l:expression

endfunction

" ----------------------------------------------
" Metacommands

function! DoVim(directive)

  " Search for '#vim' or '#previm' directives, depending on the argument,
  " and execute their Vim commands.
  "
  " Syntax:
  " #previm Any-Vim-Ex-Command
  " #vim Any-Vim-Ex-Command

  call cursor(1,1) " Go to the top of the file.

  " Empty dictionary to store the Vim commands; their line
  " number, padded with zeroes, will be used as key:
  let l:command={}

  " Search for all directives and store their line numbers and
  " Vim commands

  let l:directiveExpr='^\s*'.a:directive.'\s\+'
  while search(l:directiveExpr,'Wc')
    let l:key=matchstr('00000000'.string(line('.')),'.\{8}$')
    let l:line=getline(line('.'))
    let l:command[l:key]=strpart(l:line,matchend(l:line,l:directiveExpr))
    call setline('.','') " blank the line
  endwhile

  if len(l:command)

    " Execute all Vim commands

    for l:key in sort(keys(l:command))
      call cursor(str2nr(l:key),1)
      " XXX TODO make 'silent' configurable
      " XXX with 'silent', wrong regexp in substitutions are hard to notice!
      execute 'silent! '.l:command[l:key]
    endfor

    if len(l:command)==1
      echo "One '".a:directive."' directive executed'"
    else
      echo len(l:command)." '".a:directive."' vim directives executed"
    endif

  endif

  call SaveStep(strpart(a:directive,1).'_directives')

endfunction

function! Vim()

  " Search for all '#previm' and '#vim' directives and execute
  " their Vim commands.

  call DoVim('#previm')
  call DoVim('#vim')

  " Remove the empty lines (this is not done also after
  " executing the '#previm' directives , in order to help
  " comparing the position of the directives in both steps file,
  " if needed for debugging; besides, it would be of no use):

  silent! %s/^\n//e

endfunction

function! Include()

  " Execute all '#include' directives.

  " Syntax:
  " #include file-name

  " Warning: nested including is possible, but no recursion check is made!

  call cursor(1,1) " Go to the top of the file.
  let l:includedFiles=0 " Counter
  while search('^\s*#include\s\+','Wc')
    let l:includedFiles += 1
    let l:include=getline('.')
    let l:filenamePos=matchend(l:include,'^\s*#include\s\+')
    let l:filename=strpart(l:include,l:filenamePos)
    call setline('.','// <<< start of included file '.l:filename)
    call append('.','// >>> end of included file '.l:filename)
    let l:filecontent=readfile(s:sourceFileDir.'/'.l:filename)
    call append('.',l:filecontent)
  endwhile

  if l:includedFiles==0
    echo 'No file included'
  elseif l:includedFiles==1
    echo 'One file included'
  else
    echo l:includedFiles 'files included'
  endif

  call SaveStep('included_files')

endfunction

function! ConditionalConversion()

  " Parse and interpret all conditional conversion directives.

  " XXX TODO -- Make the structure nestable.

  " Syntax:
  "
  "   #if[n]def tag
  "     ...
  "   #else
  "     ...
  "   #endif

  " '#iftarget' is a synonym of '#ifdef'.

  " Note: The conditions can not be nested.

  call cursor(1,1)

  let l:unresolvedCondition=0 " flag

  while search('^\s*#if\(\(n\)\?def\|target\)\s\+.\+$','Wc')

    let l:else=0 " flag

"    echo 'XXX first #if[n]def found'

    while line('.')<line('$') " not at the end of the file?

      let l:currentLine=getline('.')

      if l:currentLine=~'^\s*#if\(def\|target\)\s\+.\+'
        " #IFDEF
"        echo 'XXX #ifdef found'
        if l:unresolvedCondition
          echoerr '`#if[n]def` and `#iftarget` structures can not be nested'
          break
        else
          call Ifdef()
          let l:unresolvedCondition=1
        endif
      elseif l:currentLine=~'^\s*#ifndef\s\+.\+'
        " #IFNDEF
"        echo 'XXX #ifndef found ----------------------'
        if l:unresolvedCondition
          echoerr '`#ifndef` structures can not be nested'
          break
        else
          call Ifdef()
          let l:unresolvedCondition=1
        endif
"      elseif l:currentLine=~'^\s*#elseifdef\s\+.\+'
"        " #ELSEIFDEF
"        call setline('.','')
"        if !l:unresolvedCondition
"          " XXX TODO
"        endif
"      elseif l:currentLine=~'^\s*#elseifndef\s\+.\+'
"        " #ELSEIFNDEF
"        call setline('.','')
"        if !l:unresolvedCondition
"          " XXX TODO
"        endif
      elseif l:currentLine=~'^\s*#else\s*$'
        " #ELSE
"        echo 'XXX #else found'
        if l:else
          echoerr 'More than one `#else` in a `#if[n]def` or `#iftarget` structure'
          break
        else
          let l:else=1
          call setline('.','')
          let s:keepSource=!s:keepSource
        endif
      elseif l:currentLine=~'^\s*#endif\s*$'
        " #ENDIF
"        echo 'XXX #endif found'
        call setline('.','')
        let l:unresolvedCondition=0
        break
      else
        if l:unresolvedCondition && !s:keepSource
            call setline('.','')
        endif
      endif

      call cursor(line('.')+1,1) " go to the next line

    endwhile

    if l:unresolvedCondition
      echoerr '`#if[n]def` or `#iftarget` without `#endif` at line '.l:ifLineNumber
    endif

  endwhile

  echo 'Conditional conversion done'
  call SaveStep('conditional_conversion')

endfunction

function! Ifdef()

    let l:ifLineNumber=line('.')
    let l:tagPos=matchend(getline('.'),'^\s*#if\(\(n\)\?def\|target\)\s\+')
    let l:tag=Trim(strpart(getline('.'),l:tagPos))
"    echo 'XXX l:tag='.l:tag
    let l:tagMustBeDefined=(getline('.')=~'^\s*#if\(def\|target\)')
"    echo 'XXX l:tagMustBeDefined='.l:tagMustBeDefined
    let l:tagIsDefined=Defined(l:tag)
"    echo 'XXX l:tagIsDefined='.l:tagIsDefined
    let s:keepSource=(l:tagMustBeDefined && l:tagIsDefined) || (!l:tagMustBeDefined && !l:tagIsDefined)
"    echo 'XXX s:keepSource='.s:keepSource
    call setline('.','')

endfunction

" ----------------------------------------------
" Config commands

function! Config()

  " Search and parse the config directives.  They can be anywhere in the source
  " but always at the start of a line (with optional indentation).

  " #target <BASIC dialect identifier>
  call Target()
  " #renumLine <line number>
  call RenumLine()
  " #procedureCall <keyword>
  call ProcedureCall()
  " #run <label or line number>
  call Run()
  " #define <tag>
  call Define()

  call SaveStep('config_values')

endfunction

function! Target()

  " Store into 's:target' the name of the BASIC dialect target.  Only the
  " first occurence of '#target' will be used; it can be anywhere in the
  " source but always at the start of a line (with optional indentation).
  "
  " XXX TODO -- Planned targets:
  " - pcbasic
  " - gwbasic
  " - zxspectrumbasic
  " - msxbasic

  let s:target="pcbasic" " default value

  call cursor(1,1) " Go to the top of the file.
  if search('^\s*#target\s\+','Wc')
    let l:valuePos=matchend(getline('.'),'^\s*#target\s\+')
    let s:target=strpart(getline('.'),l:valuePos)
    if !empty(s:target)
      call add(s:definedTags,s:target)
    endif
    call setline('.','')
  endif
  echo 'Target: '.s:target
  
  call SaveStep('target')

endfunction


function! RenumLine()

  " Store into 's:renumLine' the first line number to be used by the 
  " target BASIC program.  The command '#renumLine' can be used to set the
  " desired line number. Only the first occurence of '#renumLine' will be
  " used; it can be anywhere in the source but always at the start of a line
  " (with optional indentation).

  let s:renumLine=1 " default value

  call cursor(1,1) " Go to the top of the file.
  if search('^\s*#renumline\>','Wc')
    let l:valuePos=matchend(getline('.'),'^\s*#renumline\s*')
    let s:renumLine=strpart(getline('.'),l:valuePos)
    call setline('.','')
  endif
  " XXX TODO check the number
  echo 'Renum line: '.s:renumLine

endfunction

function! ProcedureCall()

  " Store into 's:procedureCall' the command used in the source by the target
  " BASIC program.  The command '#procedureCall' can be used to set the
  " desired line number. Only the first occurence of '#procedureCall' will be
  " used; it can be anywhere in the source but always at the start of a line
  " (with optional indentation).

  let s:procedureCall='call' " default value

  call cursor(1,1) " Go to the top of the file.
  if search('^\s*#procedurecall\>','Wc')
    let l:valuePos=matchend(getline('.'),'^\s*#procedurecall\s*')
    let s:procedureCall=strpart(getline('.'),l:valuePos)
    call setline('.','')
  endif

  echo s:procedureCall ? 'Procedure call prefix: '.s:procedureCall : 'No procedure call prefix'

endfunction

function! Run()

  " Config the auto-run line number.

  " XXX TODO -- useful only for some dialects

  " The command '#run' can be used to set the desired line
  " number or label. Only the first occurence of '#run' will be
  " used; it can be anywhere in the source but always at the
  " start of a line (with optional indentation).

  let s:run='' " default value (no auto-run)
  call cursor(1,1) " Go to the top of the file.
  if search('^\s*#run\>','Wc')
    let l:valuePos=matchend(getline('.'),'^\s*#run\s*')
    let s:run=strpart(getline('.'),l:valuePos)
    call setline('.','')
  endif

  echo empty(s:run) ? 'No auto-run' : 'Auto-run: '.s:run

endfunction

" XXX OLD
"
" XXX TODO -- restore it, because the directive will be ignored in BASIC
" targets that don't need it:

" function! RunLabel()

"   " Config the auto-run line number.

"   " The command '#runLabel' can be used to set the desired label. Only the
"   " first occurence of '#runLabel' will be used; it can be anywhere in the
"   " source but always at the start of a line (with optional indentation).

"   let s:runLabel='' " default value (no auto-run)
"   call cursor(1,1) " Go to the top of the file.
"   if search('^\s*#runLabel\>','Wc')
"     let l:valuePos=matchend(getline('.'),'^\s*#runLabel\s*')
"     let s:runLabel=strpart(getline('.'),l:valuePos)
"     call setline('.','')
"   endif

"   echo empty(s:runLabel) ? 'No auto-run' : 'Auto-run label: '.s:runLabel

" endfunction

function! Define()

  " Search and execute all '#define' directives.

  " There can be any number of '#define' directives, but they must be alone on
  " their own source lines (with optional indentation).

  call cursor(1,1) " Go to the top of the file.
  while search('^\s*#define\s\+','Wc')
    let l:definition=getline('.')
    let l:tagPos=matchend(l:definition,'^\s*#define\s\+')
    let l:tag=strpart(l:definition,l:tagPos)
    if !empty(l:tag)
      call add(s:definedTags,l:tag)
    endif
    call setline('.','')
  endwhile

  let l:tags=len(s:definedTags)
  if l:tags==1
    echo l:tags.' #define directive'
  elseif l:tags>1
    echo l:tags.' #define directives'
  endif

  call SaveStep('defined_tags')

endfunction

function! Defined(needle)

  " Is needle a defined tag?

"  echo "XXX About to search for the <".a:needle."> tag!"
  let l:found=0 " XXX needed, but why? Otherwise, error: undefined variable
  for l:tag in s:definedTags
"      echo 'XXX tag: '.l:tag
      let l:found=(l:tag==a:needle)
      if l:found
          break
      endif
  endfor
  return l:found

endfunction

" ----------------------------------------------
" Labels and line numbers

function! Labels()

  " Sintax:

  " Label names must start with '@'. The rest of the name must be letters A-Z,
  " a-z, digits or underscores.

  " A label is defined by putting the label name at the start of a line. If a
  " BASIC command follows it, a colon or a space are required between them.

  " The label references are the label names. They will be substituted with
  " the correspondent line number anywhere in the source -- even in text
  " strings!

  let l:ignoreCaseBackup=&ignorecase
  set ignorecase

  " Join every label to its following line:

  call cursor(1,1)
  while search('^\(@[0-9a-zA-Z_]\+\s\?\)\+$','Wce')
    join
  endwhile

  call SaveStep('labels_joined_to_following_line')

  " Create an empty dictionary to store the line numbers of the labels;
  " the labels will be used as keys:
  let l:lineNumber={}

  " Go to the top of the file:
  call cursor(1,1)

    " Search for label definitions and store them into the dictionary:
  while search('^@[0-9a-zA-Z_]\+\>','w')

    " Store the found label into register 'l':
    normal "l2dw
    " XXX INFORMER
"    echo 'Raw label found: <' . getreg('l',1) . '>'
"    let l:label=tolower(getreg('l',1))
    let l:label=Trim(getreg('l',1))
    let l:labelValue=line('.')+s:renumLine-1
    " XXX INFORMER
    "echo '  XXX Clean label: <' . l:label . '> = '.l:labelValue
    " Use the label as the key to its line number:
    let l:lineNumber[l:label]=l:labelValue
  endwhile

  " Remove all label definitions:
  silent! %substitute/^@[0-9a-zA-Z_]\+\s*:\?\s*//ei

  call SaveStep('label_definitions_removed')

  " Substitute every label reference with its line number:
  for l:label in keys(l:lineNumber)

    " XXX INFORMER
    "echo 'About to search for label '.l:label.', whose line number is '.l:lineNumber[l:label]
    "call input('Press ENTER to continue')

    call cursor(1,1) " Go to the top of the file.
    " Do the subtitution:
    while search(l:label.'\>','Wc')

      if 0
        " XXX INFORMER
        echo l:label "label reference found in line" line('.') ":"
        echo getline('.')
        echo 'About to translate it to ' l:lineNumber[l:label]
        call input('Press ENTER to continue')
        execute 'substitute/'.l:label.'\>/'.l:lineNumber[l:label].'/i'
      else
        execute 'silent! substitute/'.l:label.'\>/'.l:lineNumber[l:label].'/ei'
      endif
    endwhile
  endfor

  let &ignorecase=l:ignoreCaseBackup

  echo 'Labels translated'

  call SaveStep('labels_translated')

endfunction

function! Renum()

  " Call the nl program (part of the Debian coreutils package):
  execute "silent! %!nl --body-numbering=t --number-format=rn --number-width=5 --number-separator=' ' --starting-line-number=".s:renumLine." --line-increment=1 --body-numbering=a"

  " In older versions of coreutils,
  " -v sets the first line number, and -i sets the line increment.
  " (the long option for -v doesn't work, though the manual mentions it).
  " Modern versions of nl uses the clearer options
  " --first-line and --line-increment, see:
  " http://www.gnu.org/software/coreutils/manual/coreutils.html#nl-invocation

  " Remove spaces before line numbers
  " (nl's --number-width=1 would do this too):
  " XXX TMP commented out for debugging
"  silent! %substitute/^\s*//e

  " Remove empty lines
  silent! %substitute/^\s*\d\+\s\+\n//e

  echo 'Line numbers added'

  call SaveStep('line_numbers')

endfunction

" ----------------------------------------------
" Character conversion

function! SpecialChars()

  " Convert Special characters
  " from the UTF-8 source to the target BASIC charset

  " XXX TODO -- leave this to the Makefile of the BASIC project, using `iconv`

  let l:ignoreCaseBackup=&ignorecase
  set noignorecase

  " Embedded chars
  " XXX TODO -- make this optional, with a directive
  silent! %s/\\#\(\d\+\)/\=nr2char(submatch(1))/g

  echo 'Special chars converted'

  call SaveStep('special_chars_converted')

  let &ignorecase=l:ignoreCaseBackup

endfunction

function! Byte2Char(byte)

  " Convert the given byte to a string
  " in the format of the selected TAP maker.

  " XXX TODO -- adapt
  " XXX TODO -- make this optional, with a directive

  if 0 " s:tapmaker=='zmakebas'
    return '\{'.a:byte.'}'

  elseif 0 " s:tapmaker=='bas2tap'
    return '{'.strpart(printf('%04x',a:byte),2,2).'}'

  endif

endfunction

function! Address2Chars(number)

  " Convert the given 16-bit number to a string of two bytes
  " in the format of the selected TAP maker.

  " XXX TODO -- adapt

  echo 'Address2Chars(' a:number ')'
  if a:number>65535
    " XXX TODO better
    echoerr 'Invalid 16-bit number: ' a:number
  else
    let l:highByte=a:number/256
    let l:lowByte=a:number-256*l:highByte
    return Byte2Char(l:lowByte).Byte2Char(l:highByte)
  endif

endfunction

function! Addresses2Chars()

  " Convert 16-bit embedded values into two embedded bytes
  " with the format of the selected TAP maker.
  "
  " Imbastardizer uses double curly brackets for 16-bit
  " embedded values, in decimal or hex. Example:
  "
  "   let a$="{{0xFFFF}}{{2048}}"

  " XXX TODO -- adapt
  " XXX TODO -- make this optional, with a directive

  %substitute@{{\([0-9]\{-}\)}}@\=Address2Chars(submatch(1))@ge
  %substitute@{{0x\([0-9A-Fa-f]\{-}\)}}@\=Address2Chars(str2nr(submatch(1),16))@ge

endfunction

function! Chars()

  " Convert all special chars

  call Addresses2Chars()
  call SpecialChars()

endfunction

" ----------------------------------------------
" BAS file

function! BasFile()

  " Create a copy of the current source file
  " with the .bas extension added
  " and open it for editing.

  " Change to the directory of the current file:
  " XXX OLD
"  silent cd %:h

  silent update " Write the current source file if needed
  split " Split the window
  if empty(s:basFilename)
    let s:basFilename=expand('%:r').'.target.bas'
  endif
  try
  silent execute 'bd '.s:basFilename
  catch /E94:/
  endtry
  silent execute 'write! '.s:basFilename
  set nomodeline
  silent execute 'edit '.s:basFilename

  echo 'BAS file created'

endfunction

" ----------------------------------------------
" Generic functions

function! Trim(input_string)
  " Remove trailing spaces from a string.
  " Reference:
  " http://stackoverflow.com/questions/4478891/is-there-a-vimscript-equivalent-for-rubys-strip-strip-leading-and-trailing-s
  return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" ----------------------------------------------
" Debug

function! XXX(message)
  " XXX TODO
  if true
    echo message
  endif
endfunction

function! SaveStep(description)

  " Save the current version of the file being converted,
  " into the directory hold in the s:stepsDir variable,
  " for debugging purposes.

  " XXX TODO better, add 0 if s:step<10
  let l:number='00'.s:step
  let l:number=strpart(l:number,len(l:number)-2)
  " XXX TODO make the trace dir configurable
  silent execute 'write! '.s:stepsDir.s:sourceFilename.'.step_'.l:number.'_'.a:description
  let s:step=s:step+1

endfunction

" ----------------------------------------------
" Main

function! SaveVariables()
  " Save variables that will be changed
  let s:shortmessBackup=&shortmess
  set shortmess=at
  let s:ignoreCaseBackup=&ignorecase
  set ignorecase
endfunction

function! RestoreVariables()
  " Restore the variables that were changed
  let &ignorecase=s:ignoreCaseBackup
  let &shortmess=s:shortmessBackup
endfunction

function! Imbastardizer(outputFile)

  " Convert the content of the current Vim buffer, a Imbastardizer source, to
  " its BASIC target equivalent.
  "
  " This is an entry function of the converter. This function can be called
  " using a Vim key mapping (as defined in
  " <~/.vim/ftplugins/imbastardizer.vim>), manually executed with ':call
  " Imbastardizer()' or called from the provided command line wrapper
  " <imbastardizer.sh>.

  echo "output file = " a:outputFile
  " XXX TMP --

  let s:basFilename=a:outputFile

  call SaveVariables()

  " Counter for the saved step files
  let s:step=0

  " Filename of the source file, without path
  let s:sourceFilename=fnamemodify(expand('%'),':t')

  " Absolute directory of the source file
  let s:sourceFileDir=fnamemodify(expand('%'),':p:h')

  " Absolute directory to save the conversion steps into
  let s:stepsDir=s:sourceFileDir.'/imbastardizer_steps/'
  if !isdirectory(s:stepsDir)
    " XXX TODO if exists("*mkdir")
    " XXX TODO catch possible errors
    call mkdir(s:stepsDir,'',0700)
  endif

  echo "\n"
  echo 'Imbastardizer (version '.g:imbastardizer_version.') by Marcos Cruz (programandala.net)'
  echo "\n"

  let s:definedTags=[] " a list for the '#define' tags (and `#target`)

  " Conversion steps
  call BasFile()
  call Include()
  call Config()
  call ConditionalConversion()
  call Clean()
  call Vim()
  call ControlStructures()
  call Labels()
  call Renum()
  call Chars()

  " Remove the empty lines
  silent! %s/\n$//e

  " Save the final BAS file
  silent w
  silent bw
  echo 'BAS file saved and closed'

  call RestoreVariables()

endfunction

  " vim:tw=64:ts=2:sts=2:sw=2:et

