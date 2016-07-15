"
" Support for Tagbar -- https://github.com/majutsushi/tagbar
"
" Hat tip to Leonard Ehrenfried for the built-in ctags deffile:
"    https://leonard.io/blog/2013/04/editing-scala-with-vim/
"
if !exists(':Tagbar')
  finish
endif

let g:tagbar_type_klassic = {
    \ 'ctagstype' : 'klassic',
    \ 'sro'        : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

" In case you've updated/customized your ~/.ctags and prefer to use it.
if get(g:, 'klassic_use_builtin_tagbar_defs', 1)
  let g:tagbar_type_klassic.deffile = expand('<sfile>:p:h:h:h') . '/ctags/klassic.ctags'
endif
