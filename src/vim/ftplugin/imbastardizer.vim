" ~/.vim/ftplugin/imbastardizer.vim

" Vim filetype plugin for Imbastardizer

" By Marcos Cruz (programandala.net)

" This file is part of Imbastardizer
" http://programandala.net

" Change history
"
" 2016-12-14: Start, adapted from <~/.vim/ftplugin/imbastardizer.vim>.

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

" The key sequence '.tap' in normal mode runs the converter:

runtime imbastardizer.vim
nmap <silent> .bas :call Imbastardizer()<CR>

