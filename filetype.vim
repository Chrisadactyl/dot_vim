augroup filetypedetect
  au! BufNewFile,BufRead *.csv setf csv
  au! BufNewFile,BufRead *.meta setf csv
  au! BufNewFile,BufRead *.cfg setf csv
augroup END
