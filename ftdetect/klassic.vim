fun! s:DetectKlassic()
    if getline(1) =~# '^#!\(/usr\)\?/bin/env\s\+scalas\?'
        set filetype=scala
    endif
endfun

au BufRead,BufNewFile *.kl set filetype=klassic
au BufRead,BufNewFile * call s:DetectKlassic()
