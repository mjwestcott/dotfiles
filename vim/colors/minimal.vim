"------------------------------------------------------------------------------
" A minimal colorscheme indended to highlight only comments and strings.
"
" Author:  Matt Westcott <m.westcott@gmail.com> (mattwestcott.co.uk)
"------------------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "minimal"

function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

"------------------------------------------------------------------------------
" The colors

let s:Black             = { "gui": "#333333", "cterm": "236" }
let s:Black2            = { "gui": "#3a3a3a", "cterm": "237" }
let s:Black3            = { "gui": "#444444", "cterm": "238" }
let s:Dark_Grey         = { "gui": "#484848", "cterm": "59"  }
let s:Grey              = { "gui": "#767676", "cterm": "102" }
let s:Light_Grey        = { "gui": "#bdbdbd", "cterm": "145" }
let s:Pale_Grey         = { "gui": "#eaeaea", "cterm": "255" }
let s:White             = { "gui": "#f6f6f6", "cterm": "231" }
let s:Pale_Blue         = { "gui": "#aad8f1", "cterm": "153" }
let s:Light_Blue        = { "gui": "#94b1ca", "cterm": "110" }
let s:Dark_Grey_Blue    = { "gui": "#507892", "cterm": "66"  }
let s:Blue_Black        = { "gui": "#484f53", "cterm": "239" }
let s:Terracotta        = { "gui": "#c05303", "cterm": "130" }
let s:Orange            = { "gui": "#ff9b0b", "cterm": "214" }
let s:Pale_Yellow       = { "gui": "#ffce4b", "cterm": "221" }
let s:Pastel_Red        = { "gui": "#ff5b3a", "cterm": "203" }
let s:Red               = { "gui": "#cc2b12", "cterm": "160" }
let s:Dark_Red          = { "gui": "#800c0c", "cterm": "88"  }
let s:Pink              = { "gui": "#fdadba", "cterm": "217" }
let s:Pale_Green        = { "gui": "#72af7e", "cterm": "72"  }
let s:Dark_Green        = { "gui": "#1c6326", "cterm": "22"  }
let s:Flourescent_Green = { "gui": "#aad801", "cterm": "148" }

"------------------------------------------------------------------------------
" Main highlights

call s:h("Cursor",        { "gui": "reverse" })

if has("gui_running")
    call s:h("Normal",        { "fg": s:Pale_Grey, "bg": s:Blue_Black })
else
    " The Blue_Black color doesn't have a great match in 256 colors.
    " So set ctermbg=NONE, i.e. delegate to the terminal's background color.
    call s:h("Normal",        { "fg": s:Pale_Grey })
endif
hi! link Boolean          Normal
hi! link Number           Normal
hi! link Float            Normal

call s:h("Function",      { "fg": s:Pale_Grey })
hi! link SpecialKey       Function
hi! link Directory        Function

call s:h("Constant",      { "fg": s:Light_Blue })
hi! link String           Constant
hi! link Character        Constant

call s:h("Comment",       { "fg": s:Pale_Green })

call s:h("Special",       { "fg": s:Pink })
hi! link Todo             Special
hi! link Debug            Special
hi! link SpecialChar      Special
hi! link SpecialComment   Special
hi! link Tag              Special

call s:h("Delimiter",     { "fg": s:Pale_Grey })

call s:h("Operator",      { "fg": s:Pale_Grey })

call s:h("Statement",     { "fg": s:Pale_Grey })
hi! link Conditional      Statement
hi! link Exception        Statement
hi! link Keyword          Statement
hi! link Label            Statement
hi! link Repeat           Statement

call s:h("Identifier",   { "fg": s:Pale_Grey })

call s:h("Type",         { "fg": s:Pale_Grey })
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type

call s:h("PreProc",      { "fg": s:Pale_Grey })
hi! link Define           Preproc
hi! link Include          Preproc
hi! link Macro            Preproc
hi! link PreCondit        PreProc

call s:h("MatchParen",   { "fg": s:Pale_Yellow, "bg": s:Grey })

call s:h("CursorLineNr", { "fg": s:Pale_Grey })

call s:h("Underlined",   { "fg": s:White, "gui": "underline", "cterm": "underline"})

"------------------------------------------------------------------------------
" Other groups

call s:h("CursorLine",   {                     "bg": s:Black2 })
call s:h("CursorColumn", {                     "bg": s:Black2 })
call s:h("VertSplit",    { "fg": s:Black2,     "bg": s:Black2 })
call s:h("StatusLine",   { "fg": s:Pale_Grey,  "bg": s:Black2 })
call s:h("StatusLineNC", { "fg": s:Grey,       "bg": s:Black2 })
call s:h("LineNr",       { "fg": s:Grey,       "bg": s:Black3 })
call s:h("SignColumn",   { "fg": s:Pale_Grey,  "bg": s:Black2 })

call s:h("Visual",       {                     "bg": s:Dark_Grey_Blue })

call s:h("Search",       { "fg": s:Black,      "bg": s:Pale_Yellow })

call s:h("NonText",      { "fg": s:Pale_Grey })
call s:h("Title",        { "fg": s:Pale_Grey })

call s:h("ModeMsg",      { "fg": s:Pink })

call s:h("Error",        { "fg": s:Pale_Grey,  "bg": s:Red })
call s:h("ColorColumn",  { "fg": s:Pale_Grey,  "bg": s:Red })

call s:h("Pmenu",        { "fg": s:Light_Blue, "bg": s:Black2 })
call s:h("PmenuSel",     { "fg": s:Pale_Blue,  "bg": s:Black3 })

call s:h("FoldColumn",   { "fg": s:Pink,       "bg": s:Black3 })
call s:h("Folded",       { "fg": s:Pink,       "bg": s:Black3 })

"------------------------------------------------------------------------------
" Indent-Guides

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

call s:h("IndentGuidesEven", { "bg": s:Light_Grey })
call s:h("IndentGuidesOdd",  { "bg": s:Light_Grey })

"------------------------------------------------------------------------------
" C

hi link cStructure    Statement
hi link cStorageClass Statement

"------------------------------------------------------------------------------
" Python

hi link pythonOperator   Statement
hi link pythonDecorator  Statement
hi link pythonDottedName Statement
hi link pythonDot        Normal
hi link pythonBuiltinObj Number
hi link pythonBoolean    Boolean
hi link pythonImport     Statement

"------------------------------------------------------------------------------
" Go

hi link goBuiltins  Normal
hi link goStruct    Normal
hi link goStructDef Function
hi link goTypeDef   Function
hi link goType      Type

"------------------------------------------------------------------------------
" Clojure

hi link clojureParen    Delimiter
hi link clojureKeyword  Statement
hi link clojureDefine   Statement
hi link clojureConstant Number
hi link clojureBoolean  Boolean
hi link clojureFunc     Normal
hi link clojureSpecial  Normal
hi link clojureCond     Normal
hi link clojureRepeat   Normal

"------------------------------------------------------------------------------
" Haskell

hi link haskellIdentifier Special
hi link haskellType       Function

"------------------------------------------------------------------------------
" HTML/CSS

hi link htmlTag                Comment
hi link htmlEndTag             Comment
hi link htmlArg                Comment
hi link htmlTagName            Statement
hi link htmlSpecialTagName     Statement
hi link htmlStatement          Statement
hi link jinjaVariable          Special
hi link jinjaVarBlock          Special
hi link jinjaTagBlock          Special
hi link jinjaOperator          Special
hi link cssTagName             Special
hi link cssClassName           Normal
hi link cssClassNameDot        Normal
hi link cssIdentifer           Normal
hi link cssProp                Statement
hi link cssValueNumber         Constant
hi link cssValueAngle          Constant
hi link cssValueFrequency      Constant
hi link cssValueInteger        Constant
hi link cssValueLength         Constant
hi link cssValueTime           Constant
hi link cssValueUnitDecorators Constant
hi link cssUnitDecorators      Constant

"------------------------------------------------------------------------------
" Lisp

hi link lispDecl   Normal
hi link lispFunc   Normal
hi link lispConcat Normal
hi link lispVar    Normal
hi link lispSymbol Normal

"------------------------------------------------------------------------------
" Diff

call s:h("DiffAdd",    { "bg": s:Dark_Green })
call s:h("DiffDelete", { "bg": s:Red })
call s:h("DiffChange", { "bg": s:Dark_Grey })
call s:h("DiffText",   { "bg": s:Dark_Red })

"------------------------------------------------------------------------------
" vim-gitgutter

call s:h("GitGutterAdd",          { "fg": s:Dark_Green, "bg": s:Black2 })
call s:h("GitGutterDelete",       { "fg": s:Red,        "bg": s:Black2 })
call s:h("GitGutterChange",       { "fg": s:Dark_Red,   "bg": s:Black2 })
call s:h("GitGutterChangeDelete", { "fg": s:Dark_Red,   "bg": s:Black2 })

"------------------------------------------------------------------------------
" TagBar

call s:h("TagbarVisibilityPublic",    { "fg": s:Dark_Green })
call s:h("TagbarVisibilityPrivate",   { "fg": s:Dark_Red })
call s:h("TagbarVisibilityProtected", { "fg": s:Terracotta })

"------------------------------------------------------------------------------
" gitCommit

call s:h("diffAdded",   { "fg": s:Flourescent_Green })
call s:h("diffRemoved", { "fg": s:Pastel_Red })
call s:h("diffChanged", { "fg": s:Orange })
hi link diffLine Constant

"------------------------------------------------------------------------------
" Vim

hi link HelpCommand     Statement
hi link HelpExample     Statement
hi link vimCommand      Statement
hi link vimOption       Function
hi link vimCommentTitle Function
