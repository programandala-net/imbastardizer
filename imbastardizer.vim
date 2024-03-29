" imbastardizer.vim

" Imbastardizer

" Version 1.0.0-dev.0.8.0+20210418T1711CEST.

" Copyright (C) 2016,2017,2021 Marcos Cruz (programandala.net)

" You may do whatever you want with this work, so long as you retain
" the copyright/authorship/acknowledgment/credit notice(s) and this
" license in all redistributed copies and derived works.  There is no
" warranty.

" http://programandala.net/en.program.imbastardizer.html

" ==============================================================
" Requirements

" nl from the GNG Coreutils.
" http://www.gnu.org/software/coreutils/manual/coreutils.html#nl-invocation

" ==============================================================
" Clean {{{1

function! Clean()

  " Clean the source code.

  "silent! %s/^\s\+//e " Remove indentation
  "silent! %s/\s\+$//e " Remove trailing spaces
  " Remove leading and trailing spaces
  silent! %s/\s*\(.\+\)\?\s*$/\1/e

  " Remove hash line comments
  silent! %s/^\s*#\( .*\)\?\n//e

  " Remove empty lines
  silent! %s/\%^\n\+//e " at the top of the file
  silent! %s/\n\n\+/\r/e
  silent! %s/\n\+\%$//e " at the bottom of the file

  " Join splitted lines
  silent! %s/\\\n//e

  call SaveStep('clean')

endfunction

" ==============================================================
" Directives {{{1

" ----------------------------------------------
" #vim {{{2

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

  call SaveStep(strpart(a:directive,1,len(a:directive)-1).'_directive_processed')

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

  call SaveStep('empty_lines_removed')

endfunction

" ----------------------------------------------
" #include {{{2

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
    call setline('.','# <<< start of included file '.l:filename)
    call append('.','# >>> end of included file '.l:filename)
    let l:filecontent=readfile(s:sourceFileDir.'/'.l:filename)
    call append('.',l:filecontent)
  endwhile

  " XXX OLD
  " if l:includedFiles==0
  "   echo 'No file included'
  " elseif l:includedFiles==1
  "   echo 'One file included'
  " else
  "   echo l:includedFiles 'files included'
  " endif

  call SaveStep('include_directive_processed')

endfunction

" ----------------------------------------------
" #ifdef {{{2

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

  " Note: The conditions can not be nested.

  call cursor(1,1)

  let l:unresolvedCondition=0 " flag

  while search('^\s*#if\(n\)\?def\s\+.\+$','Wc')

    let l:else=0 " flag

"    echo 'XXX first #if[n]def found'

    while line('.')<line('$') " not at the end of the file?

      let l:currentLine=getline('.')

      if l:currentLine=~'^\s*#ifdef\s\+.\+'
        " #IFDEF
"        echo 'XXX #ifdef found'
        if l:unresolvedCondition
          echoerr '`#if[n]def` structures can not be nested'
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
          echoerr 'More than one `#else` in a `#if[n]def` structure'
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
      echoerr '`#if[n]def` or without `#endif` at line '.l:ifLineNumber
    endif

  endwhile

  call SaveStep('ifdef_directive_processed')

endfunction

function! Ifdef()

    let l:ifLineNumber=line('.')
    let l:tagPos=matchend(getline('.'),'^\s*#if\(n\)\?def\s\+')
    let l:tag=Trim(strpart(getline('.'),l:tagPos))
"    echo 'XXX l:tag='.l:tag
    let l:tagMustBeDefined=(getline('.')=~'^\s*#ifdef')
"    echo 'XXX l:tagMustBeDefined='.l:tagMustBeDefined
    let l:tagIsDefined=Defined(l:tag)
"    echo 'XXX l:tagIsDefined='.l:tagIsDefined
    let s:keepSource=(l:tagMustBeDefined && l:tagIsDefined) || (!l:tagMustBeDefined && !l:tagIsDefined)
"    echo 'XXX s:keepSource='.s:keepSource
    call setline('.','')

endfunction

" ----------------------------------------------
" #define {{{2

function! Define()

  " Search for and execute all '#define' directives.

  " There can be any number of '#define' directives, but they must be alone on
  " their own source lines (with optional indentation).

  let s:definedTags=[] " a list for the '#define' tags

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

  " XXX OLD
  " let l:tags=len(s:definedTags)
  " if l:tags==1
  "   echo l:tags.' #define directive'
  " elseif l:tags>1
  "   echo l:tags.' #define directives'
  " endif

  call SaveStep('define_directive_processed')

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

" ==============================================================
" Labels and line numbers {{{1

function! Labels()

  " Sintax:

  " A label is defined with the text `@label:' at the beginning
  " of a line (possibly preceded by whitespace). It can be
  " referred to (before or after) with  `@label'. Only letters
  " A-Z, a-z, digits, dots and underscores can be used in a
  " label name.
  "
  " Label references will be replaced with the correspondent
  " line number anywhere in the source, even in text strings!

  " Join every label to its following line:

  call cursor(1,1)
  while search('^\(\s*@[0-9a-zA-Z_.]\+:\s*\)\+$','Wce')
    join
  endwhile

  call SaveStep('label_definitions_joined_to_the_following_line')

  " Create an empty dictionary to store the line numbers of the labels;
  " the labels will be used as keys:
  let l:lineNumber={}

  " Go to the top of the file:
  call cursor(1,1)

  " Search for label definitions and store them into the dictionary:
  while search('^\s*@[0-9a-zA-Z_.]\+:\s*','w')

    " Skip possible leading spaces, left by a previous label on
    " the same code line:
    call search('\S','c')

    " Store the found label into register 'l' and remove its
    " trailing colon:
    normal "l2dwx

    " XXX INFORMER
"    echo 'Raw label found: <' . getreg('l',1) . '>'
"    let l:label=tolower(getreg('l',1))

    let l:label=Trim(getreg('l',1))

    " XXX OLD, used when the trailing colon was not removed in
    " normal mode:
    " let l:label=strpart(l:label,0,len(l:label)-1)

    let l:labelValue=line('.')+s:renumLine-1

    " XXX INFORMER
"    echo '  XXX Clean label: <' . l:label . '> = '.l:labelValue

    " Use the label as the key to its line number:
    let l:lineNumber[l:label]=l:labelValue

  endwhile

  " Remove leading spaces, possibly left by labels:
  silent! %s/\s*\(.\+\)\?$/\1/e

  call SaveStep('label_definitions_removed')

  " Replace every label reference with its line number:

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

  call SaveStep('labels_translated')

endfunction

function! Renum()

  " Add line numbers.

  " Requirement: nl from the GNG Coreutils.
  " http://www.gnu.org/software/coreutils/manual/coreutils.html#nl-invocation

  execute "silent! %!nl --body-numbering=t --number-format=rn --number-width=1 --number-separator=' ' --starting-line-number=".s:renumLine." --line-increment=1 --body-numbering=a"

  " XXX OLD
  " Remove empty lines
  " silent! %substitute/^\s*\d\+\s\+\n//e

  call SaveStep('line_numbers_added')

endfunction

" ==============================================================
" Generic functions {{{1

function! Trim(input_string)

  " Remove trailing spaces from a string.

  " Reference:
  " http://stackoverflow.com/questions/4478891/is-there-a-vimscript-equivalent-for-rubys-strip-strip-leading-and-trailing-s

  return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')

endfunction

" ==============================================================
" Debug {{{1

function! SaveStep(description)

  " Save the current version of the file being converted,
  " into the directory hold in the s:stepsDir variable,
  " for debugging purposes.

  let l:number='000'.s:step
  let l:number=strpart(l:number,len(l:number)-3)
  silent execute 'write! '.s:stepsDir.s:sourceFilename.'.step_'.l:number.'_'.a:description
  let s:step=s:step+1

endfunction

" ==============================================================
" Main {{{1

"function! Imbastardizer()

  " Convert the content of the current Vim buffer.

  let s:shortmessBackup=&shortmess
  set shortmess=at
  let s:ignorecaseBackup=&ignorecase
  set ignorecase

  " Open all folds (otherwise joining the labels to their
  " following line fails):
  set nofoldenable

  let s:renumLine=1

  " Counter for the saved step files
  let s:step=0

  " Filename of the source file, without path
  let s:sourceFilename=fnamemodify(expand('%'),':t')

  " Absolute directory of the source file
  let s:sourceFileDir=fnamemodify(expand('%'),':p:h')

  " Absolute directory to save the conversion steps into
  " XXX TODO Make the steps dir configurable.
  let s:stepsDir=s:sourceFileDir.'/imbastardizer_steps/'
  if !isdirectory(s:stepsDir)
    " XXX TODO if exists("*mkdir")
    " XXX TODO catch possible errors
    call mkdir(s:stepsDir,'',0700)
  endif

  " Conversion steps
  call SaveStep('untouched_original')
  "call Include()
  call Define()
  call ConditionalConversion()
  call Clean()
  "call Vim()
  call Labels()
  call Renum()

  " Remove the empty lines
  silent! %s/\n$//e
  call SaveStep('empty_lines_removed')

  " Restore the variables that were changed
  let &ignorecase=s:ignorecaseBackup
  let &shortmess=s:shortmessBackup

"endfunction

" vim:tw=64:ts=2:sts=2:sw=2:et
