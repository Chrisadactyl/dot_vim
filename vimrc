call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


:set number
:set et
:set sw=2
:set tags=/usr/local/webapps/kyle/tags.ctags
:set nocompatible
:set hls
:filetype indent plugin on
:synta on

" http://items.sjbach.com/319/configuring-vim-right
set history=1000
set wildmenu
let mapleader = "\\"
set ignorecase
set smartcase

" paste last copied item (not deleted)
:nmap <Leader>v "0p

" split window horizontal/vertical
:nmap <Leader>w <c-w>s
:nmap <Leader>e <c-w>v

" add highlighting to mystery files
:nmap <Leader>h :runtime! syntax/apache.vim<enter>


" http://vim.wikia.com/wiki/Pretty-formatting_XML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set runtimepath^=~/.vim/bundle/ctrlp.vim
