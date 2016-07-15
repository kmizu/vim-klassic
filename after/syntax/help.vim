" Extends standard help syntax with highlighting of Klassic code.
"
" Place code between !sc! and !/sc! delimiters. These will be hidden if Vim is
" built with conceal support.

unlet! b:current_syntax

syntax include @KlassicCode syntax/klassic.vim

if has('conceal')
  syntax region rgnKlassic matchgroup=Ignore concealends start='!sc!' end='!/sc!' contains=@KlassicCode
else
  syntax region rgnKlassic matchgroup=Ignore start='!sc!' end='!/sc!' contains=@KlassicCode
endif
