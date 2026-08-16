" Neovim's bundled Kitty syntax treats a leading map flag as the key itself.
" Classify only that missing syntax atom here; the active colorscheme owns colors.
syntax match kittyMapFlag /--[[:alnum:]_-]\+\%([=][^ \t\r\n]\+\)\?/ contained containedin=kittyMapSeq
highlight! default link kittyMapFlag Special

" Preserve Neovim's stock semantic links across colorscheme :highlight clear.
highlight! default link kittyString String
highlight! default link kittyNumber Number
highlight! default link kittyAlpha Type
highlight! default link kittyColor Constant
highlight! default link kittyBoolean Boolean
highlight! default link kittyConstant Constant
highlight! default link kittyFlag Constant
highlight! default link kittyParameter Special
highlight! default link kittyOptionName Keyword
highlight! default link kittyModName Keyword
highlight! default link kittyKey Special
highlight! default link kittyCtrl Constant
highlight! default link kittyAlt Constant
highlight! default link kittyShift Constant
highlight! default link kittySuper Constant
highlight! default link kittyAnd Operator
highlight! default link kittyWith Operator
highlight! default link kittyMapName Function
highlight! default link kittyMouseMapName Function
highlight! default link kittyMouseMapType Type
highlight! default link kittyMouseMapGrabbed Constant
highlight! default link kittyComment Comment
highlight! default link kittyLineContinue Comment

if get(g:, 'colors_name', '') ==# 'alabaster-oled'
  lua require('alabaster_oled').apply_kitty()
endif
