fun! s:DetectKlassic()
    if getline(1) =~# '^#!\(/usr\)\?/bin/env\s\+klassics\?'
        set filetype=klassic
    endif
endfun

au BufRead,BufNewFile *.kl set filetype=klassic
au BufRead,BufNewFile * call s:DetectKlassic()
