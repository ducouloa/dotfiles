autocmd BufRead,BufNewFile [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}.wiki imap þ ----:r! date +"\%H:\%M"I_A_:
