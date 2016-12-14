" ~/.vim/ftplugin/msximbasic.vim

" Vim filetype plugin for MSX-imBASIC

" By Marcos Cruz (programandala.net)

" This file is part of MSX-imBASIC
" http://programandala.net/en.program.msx-imbasic.html

" Change history
"
" 2016-10-30: Start, adapted from <~/.vim/ftplugin/vimclair_basic.vim>.

setlocal tabstop=2
setlocal softtabstop=0
setlocal shiftwidth=2
setlocal expandtab
setlocal foldmethod=marker
setlocal textwidth=70
setlocal comments=b:#,://,:'

setlocal formatoptions=cqorj

" Note: The "j" flag in 'formatoptions' removes a comment leader when joining
" lines.  See ':help fo-table' for details.

" Used by the Vim-Commentary plugin:
"setlocal commentstring=//\ %s
" '#' is more convenient, because it's used for commenting out, not for actual
" comments:
setlocal commentstring=#\ %s

" The key sequence '.tap' in normal mode
" runs the vbas2tap converter:

runtime msximbas2.vim
nmap <silent> .dsk :call MSXimbas2dsk()<CR>
nmap <silent> .bas :call MSXimbas2bas()<CR>

