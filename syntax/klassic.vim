" Vim syntax file
" Language:             Klassic
" Maintainer:           Kota Mizushima
" URL:                  https://github.com/kmizu/vim-klassic
" License:              MIT License
" ----------------------------------------------------------------------------

if !exists('main_syntax')
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'klassic'
endif

scriptencoding utf-8

let b:current_syntax = "klassic"

" Allows for embedding, see #59; main_syntax convention instead? Refactor TOP
"
" The @Spell here is a weird hack, it means *exclude* if the first group is
" TOP. Otherwise we get spelling errors highlighted on code elements that
" match klassicBlock, even with `syn spell notoplevel`.
function! s:ContainedGroup()
  try
    silent syn list @klassic
    return '@klassic,@NoSpell'
  catch /E392/
    return 'TOP,@Spell'
  endtry
endfunction

unlet! b:current_syntax

syn case match
syn sync minlines=200 maxlines=1000

syn keyword klassicKeyword catch do else final finally for forSome if
syn keyword klassicKeyword match return throw try while yield macro
syn keyword klassicKeyword class trait object extends with nextgroup=klassicInstanceDeclaration skipwhite
syn keyword klassicKeyword case nextgroup=klassicKeyword,klassicCaseFollowing skipwhite
syn keyword klassicKeyword val nextgroup=klassicNameDefinition,klassicQuasiQuotes skipwhite
syn keyword klassicKeyword def var nextgroup=klassicNameDefinition skipwhite
hi link klassicKeyword Keyword

exe 'syn region klassicBlock start=/{/ end=/}/ contains=' . s:ContainedGroup() . ' fold'

syn keyword klassicAkkaSpecialWord when goto using startWith initialize onTransition stay become unbecome
hi link klassicAkkaSpecialWord PreProc

syn keyword klassictestSpecialWord shouldBe
syn match klassictestShouldDSLA /^\s\+\zsit should/
syn match klassictestShouldDSLB /\<should\>/
hi link klassictestSpecialWord PreProc
hi link klassictestShouldDSLA PreProc
hi link klassictestShouldDSLB PreProc

syn match klassicSymbol /'[_A-Za-z0-9$]\+/
hi link klassicSymbol Number

syn match klassicChar /'.'/
syn match klassicChar /'\\[\\"'ntbrf]'/ contains=klassicEscapedChar
syn match klassicChar /'\\u[A-Fa-f0-9]\{4}'/ contains=klassicUnicodeChar
syn match klassicEscapedChar /\\[\\"'ntbrf]/
syn match klassicUnicodeChar /\\u[A-Fa-f0-9]\{4}/
hi link klassicChar Character
hi link klassicEscapedChar Function
hi link klassicUnicodeChar Special

syn match klassicOperator "||"
syn match klassicOperator "&&"
hi link klassicOperator Special

syn match klassicNameDefinition /\<[_A-Za-z0-9$]\+\>/ contained nextgroup=klassicPostNameDefinition,klassicVariableDeclarationList
syn match klassicNameDefinition /`[^`]\+`/ contained nextgroup=klassicPostNameDefinition
syn match klassicVariableDeclarationList /\s*,\s*/ contained nextgroup=klassicNameDefinition
syn match klassicPostNameDefinition /\_s*:\_s*/ contained nextgroup=klassicTypeDeclaration
hi link klassicNameDefinition Function

syn match klassicInstanceDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=klassicInstanceHash
syn match klassicInstanceDeclaration /`[^`]\+`/ contained
syn match klassicInstanceHash /#/ contained nextgroup=klassicInstanceDeclaration
hi link klassicInstanceDeclaration Special
hi link klassicInstanceHash Type

syn match klassicUnimplemented /???/
hi link klassicUnimplemented ERROR

syn match klassicCapitalWord /\<[A-Z][A-Za-z0-9$]*\>/
hi link klassicCapitalWord Special

" Handle type declarations specially
syn region klassicTypeStatement matchgroup=Keyword start=/\<type\_s\+\ze/ end=/$/ contains=klassicTypeTypeDeclaration,klassicSquareBrackets,klassicTypeTypeEquals,klassicTypeStatement

" Ugh... duplication of all the klassicType* stuff to handle special highlighting
" of `type X =` declarations
syn match klassicTypeTypeDeclaration /(/ contained nextgroup=klassicTypeTypeExtension,klassicTypeTypeEquals contains=klassicRoundBrackets skipwhite
syn match klassicTypeTypeDeclaration /\%(⇒\|=>\)\ze/ contained nextgroup=klassicTypeTypeDeclaration contains=klassicTypeTypeExtension skipwhite
syn match klassicTypeTypeDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=klassicTypeTypeExtension,klassicTypeTypeEquals skipwhite
syn match klassicTypeTypeEquals /=\ze[^>]/ contained nextgroup=klassicTypeTypePostDeclaration skipwhite
syn match klassicTypeTypeExtension /)\?\_s*\zs\%(⇒\|=>\|<:\|:>\|=:=\|::\|#\)/ contained nextgroup=klassicTypeTypeDeclaration skipwhite
syn match klassicTypeTypePostDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=klassicTypeTypePostExtension skipwhite
syn match klassicTypeTypePostExtension /\%(⇒\|=>\|<:\|:>\|=:=\|::\)/ contained nextgroup=klassicTypeTypePostDeclaration skipwhite
hi link klassicTypeTypeDeclaration Type
hi link klassicTypeTypeExtension Keyword
hi link klassicTypeTypePostDeclaration Special
hi link klassicTypeTypePostExtension Keyword

syn match klassicTypeDeclaration /(/ contained nextgroup=klassicTypeExtension contains=klassicRoundBrackets skipwhite
syn match klassicTypeDeclaration /\%(⇒\|=>\)\ze/ contained nextgroup=klassicTypeDeclaration contains=klassicTypeExtension skipwhite
syn match klassicTypeDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=klassicTypeExtension skipwhite
syn match klassicTypeExtension /)\?\_s*\zs\%(⇒\|=>\|<:\|:>\|=:=\|::\|#\)/ contained nextgroup=klassicTypeDeclaration skipwhite
hi link klassicTypeDeclaration Type
hi link klassicTypeExtension Keyword
hi link klassicTypePostExtension Keyword

syn match klassicTypeAnnotation /\%([_a-zA-Z0-9$\s]:\_s*\)\ze[_=(\.A-Za-z0-9$]\+/ skipwhite nextgroup=klassicTypeDeclaration contains=klassicRoundBrackets
syn match klassicTypeAnnotation /)\_s*:\_s*\ze[_=(\.A-Za-z0-9$]\+/ skipwhite nextgroup=klassicTypeDeclaration
hi link klassicTypeAnnotation Normal

syn match klassicCaseFollowing /\<[_\.A-Za-z0-9$]\+\>/ contained
syn match klassicCaseFollowing /`[^`]\+`/ contained
hi link klassicCaseFollowing Special

syn keyword klassicKeywordModifier abstract override final lazy implicit implicitly private protected sealed null require super
hi link klassicKeywordModifier Function

syn keyword klassicSpecial this true false ne eq
syn keyword klassicSpecial new nextgroup=klassicInstanceDeclaration skipwhite
syn match klassicSpecial "\%(=>\|⇒\|<-\|←\|->\|→\)"
syn match klassicSpecial /`[^`]\+`/  " Backtick literals
hi link klassicSpecial PreProc

syn keyword klassicExternal package import
hi link klassicExternal Include

syn match klassicStringEmbeddedQuote /\\"/ contained
syn region klassicString start=/"/ end=/"/ contains=klassicStringEmbeddedQuote,klassicEscapedChar,klassicUnicodeChar
hi link klassicString String
hi link klassicStringEmbeddedQuote String

syn region klassicIString matchgroup=klassicInterpolationBrackets start=/\<[a-zA-Z][a-zA-Z0-9_]*"/ skip=/\\"/ end=/"/ contains=klassicInterpolation,klassicInterpolationB,klassicEscapedChar,klassicUnicodeChar
syn region klassicTripleIString matchgroup=klassicInterpolationBrackets start=/\<[a-zA-Z][a-zA-Z0-9_]*"""/ end=/"""\%([^"]\|$\)/ contains=klassicInterpolation,klassicInterpolationB,klassicEscapedChar,klassicUnicodeChar
hi link klassicIString String
hi link klassicTripleIString String

syn match klassicInterpolation /\$[a-zA-Z0-9_$]\+/ contained
exe 'syn region klassicInterpolationB matchgroup=klassicInterpolationBoundary start=/\${/ end=/}/ contained contains=' . s:ContainedGroup()
hi link klassicInterpolation Function
hi link klassicInterpolationB Normal

syn region klassicFString matchgroup=klassicInterpolationBrackets start=/f"/ skip=/\\"/ end=/"/ contains=klassicFInterpolation,klassicFInterpolationB,klassicEscapedChar,klassicUnicodeChar
syn match klassicFInterpolation /\$[a-zA-Z0-9_$]\+\(%[-A-Za-z0-9\.]\+\)\?/ contained
exe 'syn region klassicFInterpolationB matchgroup=klassicInterpolationBoundary start=/${/ end=/}\(%[-A-Za-z0-9\.]\+\)\?/ contained contains=' . s:ContainedGroup()
hi link klassicFString String
hi link klassicFInterpolation Function
hi link klassicFInterpolationB Normal

syn region klassicTripleString start=/"""/ end=/"""\%([^"]\|$\)/ contains=klassicEscapedChar,klassicUnicodeChar
syn region klassicTripleFString matchgroup=klassicInterpolationBrackets start=/f"""/ end=/"""\%([^"]\|$\)/ contains=klassicFInterpolation,klassicFInterpolationB,klassicEscapedChar,klassicUnicodeChar
hi link klassicTripleString String
hi link klassicTripleFString String

hi link klassicInterpolationBrackets Special
hi link klassicInterpolationBoundary Function

syn match klassicNumber /\<0[dDfFlL]\?\>/ " Just a bare 0
syn match klassicNumber /\<[1-9]\d*[dDfFlL]\?\>/  " A multi-digit number - octal numbers with leading 0's are deprecated in klassic
syn match klassicNumber /\<0[xX][0-9a-fA-F]\+[dDfFlL]\?\>/ " Hex number
syn match klassicNumber /\%(\<\d\+\.\d*\|\.\d\+\)\%([eE][-+]\=\d\+\)\=[fFdD]\=/ " exponential notation 1
syn match klassicNumber /\<\d\+[eE][-+]\=\d\+[fFdD]\=\>/ " exponential notation 2
syn match klassicNumber /\<\d\+\%([eE][-+]\=\d\+\)\=[fFdD]\>/ " exponential notation 3
hi link klassicNumber Number

syn region klassicRoundBrackets start="(" end=")" skipwhite contained contains=klassicTypeDeclaration,klassicSquareBrackets,klassicRoundBrackets

syn region klassicSquareBrackets matchgroup=klassicSquareBracketsBrackets start="\[" end="\]" skipwhite nextgroup=klassicTypeExtension contains=klassicTypeDeclaration,klassicSquareBrackets,klassicTypeOperator,klassicTypeAnnotationParameter
syn match klassicTypeOperator /[-+=:<>]\+/ contained
syn match klassicTypeAnnotationParameter /@\<[`_A-Za-z0-9$]\+\>/ contained
hi link klassicSquareBracketsBrackets Type
hi link klassicTypeOperator Keyword
hi link klassicTypeAnnotationParameter Function

syn match klassicShebang "\%^#!.*" display
syn region klassicMultilineComment start="/\*" end="\*/" contains=klassicMultilineComment,klassicDocLinks,klassicParameterAnnotation,klassicCommentAnnotation,klassicTodo,klassicCommentCodeBlock,@Spell keepend fold
syn match klassicCommentAnnotation "@[_A-Za-z0-9$]\+" contained
syn match klassicParameterAnnotation "\%(@tparam\|@param\|@see\)" nextgroup=klassicParamAnnotationValue skipwhite contained
syn match klassicParamAnnotationValue /[.`_A-Za-z0-9$]\+/ contained
syn region klassicDocLinks start="\[\[" end="\]\]" contained
syn region klassicCommentCodeBlock matchgroup=Keyword start="{{{" end="}}}" contained
syn match klassicTodo "\vTODO|FIXME|XXX" contained
hi link klassicShebang Comment
hi link klassicMultilineComment Comment
hi link klassicDocLinks Function
hi link klassicParameterAnnotation Function
hi link klassicParamAnnotationValue Keyword
hi link klassicCommentAnnotation Function
hi link klassicCommentCodeBlockBrackets String
hi link klassicCommentCodeBlock String
hi link klassicTodo Todo

syn match klassicAnnotation /@\<[`_A-Za-z0-9$]\+\>/
hi link klassicAnnotation PreProc

syn match klassicTrailingComment "//.*$" contains=klassicTodo,@Spell
hi link klassicTrailingComment Comment

syn match klassicAkkaFSM /goto([^)]*)\_s\+\<using\>/ contains=klassicAkkaFSMGotoUsing
syn match klassicAkkaFSM /stay\_s\+using/
syn match klassicAkkaFSM /^\s*stay\s*$/
syn match klassicAkkaFSM /when\ze([^)]*)/
syn match klassicAkkaFSM /startWith\ze([^)]*)/
syn match klassicAkkaFSM /initialize\ze()/
syn match klassicAkkaFSM /onTransition/
syn match klassicAkkaFSM /onTermination/
syn match klassicAkkaFSM /whenUnhandled/
syn match klassicAkkaFSMGotoUsing /\<using\>/
syn match klassicAkkaFSMGotoUsing /\<goto\>/
hi link klassicAkkaFSM PreProc
hi link klassicAkkaFSMGotoUsing PreProc

let b:current_syntax = 'klassic'

if main_syntax ==# 'klassic'
  unlet main_syntax
endif

" vim:set sw=2 sts=2 ts=8 et:
