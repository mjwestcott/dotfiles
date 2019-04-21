"------------------------------------------------------------------------------
" A minimal colorscheme indended to highlight only comments and strings.
" Color palette based on https://github.com/junegunn/seoul256.vim
"
" Author:  Matt Westcott <m.westcott@gmail.com> (mattwestcott.co.uk)
"------------------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "brown"

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
let s:Dark_Grey         = { "gui": "#3e3e3e", "cterm": "239" }
let s:Grey              = { "gui": "#767676", "cterm": "102" }
let s:Grey2             = { "gui": "#949494", "cterm": "246" }
let s:Light_Grey        = { "gui": "#bdbdbd", "cterm": "145" }
let s:Pale_Grey         = { "gui": "#c6c6c6", "cterm": "251" }
let s:Almost_White      = { "gui": "#eaeaea", "cterm": "255" }
let s:White             = { "gui": "#f6f6f6", "cterm": "231" }
let s:Pale_Blue         = { "gui": "#bce0ff", "cterm": "153" }
let s:Light_Blue        = { "gui": "#98bede", "cterm": "110" }
let s:Dark_Grey_Blue    = { "gui": "#719899", "cterm": "66"  }
let s:Blue_Black        = { "gui": "#616161", "cterm": "239" }
let s:Cyan              = { "gui": "#98bcbd", "cterm": "109" }
let s:Terracotta        = { "gui": "#be7572", "cterm": "131" }
let s:Brown             = { "gui": "#be9873", "cterm": "137" }
let s:Orange            = { "gui": "#dfbc72", "cterm": "179" }
let s:Pale_Yellow       = { "gui": "#ffde99", "cterm": "222" }
let s:Pastel_Red        = { "gui": "#e09b99", "cterm": "174" }
let s:Red               = { "gui": "#cc2b12", "cterm": "160" }
let s:Dark_Red          = { "gui": "#800c0c", "cterm": "88"  }
let s:Pink              = { "gui": "#e09b99", "cterm": "174" }
let s:Pale_Green        = { "gui": "#98bc99", "cterm": "108" }
let s:Dark_Green        = { "gui": "#719872", "cterm": "65"  }
let s:Flourescent_Green = { "gui": "#bdbb72", "cterm": "143" }

"------------------------------------------------------------------------------
" Main highlights

call s:h("Cursor",        { "gui": "reverse" })

call s:h("Normal",        { "fg": s:Pale_Grey, "bg": s:Dark_Grey })
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

call s:h("Delimiter",     { "fg": s:Orange })

call s:h("Operator",      { "fg": s:Orange })

call s:h("Statement",     { "fg": s:Orange })
hi! link Conditional      Statement
hi! link Exception        Statement
hi! link Label            Statement
hi! link Repeat           Statement
hi! link Define           Statement

call s:h("Keyword",       { "fg": s:Pale_Grey })

call s:h("Identifier",    { "fg": s:Pale_Grey })

call s:h("Type",          { "fg": s:Pale_Grey })
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type

call s:h("PreProc",       { "fg": s:Pale_Grey })
hi! link Include          Preproc
hi! link Macro            Preproc
hi! link PreCondit        PreProc

call s:h("MatchParen",    { "fg": s:Pale_Yellow, "bg": s:Grey })

call s:h("CursorLineNr",  { "fg": s:Pale_Grey })

call s:h("Underlined",    { "fg": s:White, "gui": "underline", "cterm": "underline"})

"------------------------------------------------------------------------------
" Other groups

call s:h("CursorLine",   {                     "bg": s:Black3 })
call s:h("CursorColumn", {                     "bg": s:Black3 })
call s:h("VertSplit",    { "fg": s:Black2,     "bg": s:Black2 })
call s:h("StatusLine",   { "fg": s:Pale_Grey,  "bg": s:Black2 })
call s:h("StatusLineNC", { "fg": s:Grey,       "bg": s:Black2 })
call s:h("LineNr",       { "fg": s:Grey,       "bg": s:Black3 })
call s:h("SignColumn",   { "fg": s:Pale_Grey,  "bg": s:Black2 })

call s:h("Visual",       {                     "bg": s:Black })

call s:h("Search",       { "fg": s:Black,      "bg": s:Pale_Yellow })

call s:h("NonText",      { "fg": s:Pale_Grey })
call s:h("Title",        { "fg": s:Pale_Yellow })

call s:h("ModeMsg",      { "fg": s:Pink })

call s:h("Error",        { "fg": s:Pale_Grey,  "bg": s:Red })

call s:h("ColorColumn",  { "fg": s:Red,        "bg": s:Black3 })

call s:h("Pmenu",        { "fg": s:Light_Blue, "bg": s:Black2 })
call s:h("PmenuSel",     { "fg": s:Pale_Blue,  "bg": s:Black3 })

call s:h("FoldColumn",   { "fg": s:Pink,       "bg": s:Black3 })
call s:h("Folded",       { "fg": s:Pink,       "bg": s:Black3 })

call s:h('TabLineFill',  {                     "bg": s:Black2 })
call s:h('TabLineSel',   { "fg": s:Light_Blue, "bg": s:Black2 })
call s:h('TabLine',      { "fg": s:Grey,       "bg": s:Black2 })

call s:h("SpellBad",     { "fg": s:Black2,     "bg": s:Pastel_Red   })
call s:h("SpellCap",     { "fg": s:Black2,     "bg": s:Pale_Blue    })
call s:h("SpellRare",    { "fg": s:Black2,     "bg": s:Orange       })
call s:h("SpellLocal",   { "fg": s:Black2,     "bg": s:Pale_Yellow  })

"------------------------------------------------------------------------------
" ALE

call s:h("ALEInfoSign",    { "fg": s:Pale_Green, "bg": s:Black3 })
call s:h("ALEErrorSign",   { "fg": s:Pastel_Red, "bg": s:Black3 })
call s:h("ALEWarningSign", { "fg": s:Orange,     "bg": s:Black3 })

"------------------------------------------------------------------------------
" Indent-Guides

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

call s:h("IndentGuidesEven", { "bg": s:Light_Grey })
call s:h("IndentGuidesOdd",  { "bg": s:Light_Grey })

"------------------------------------------------------------------------------
" Taskpaper

hi link taskpaperContext        Constant
hi link taskpaperComment        Comment
hi link taskpaperProject        Statement
hi link taskpaperListItem       Special
hi link taskpaperAutoStyle_FAIL Error
call s:h("taskpaperDone",      { "fg": s:Grey })
call s:h("taskpaperCancelled", { "fg": s:Grey })

"------------------------------------------------------------------------------
" C

hi link cStructure    Statement
hi link cStorageClass Statement

"------------------------------------------------------------------------------
" Python

hi link pythonOperator   Operator
hi link pythonDecorator  Operator
hi link pythonDot        Operator
hi link pythonDottedName Normal
hi link pythonImport     Statement
hi link pythonBuiltinObj Number
hi link pythonBoolean    Boolean

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
hi link clojureConstant Number
hi link clojureBoolean  Boolean
hi link clojureDefine   Normal
hi link clojureFunc     Normal
hi link clojureSpecial  Normal
hi link clojureCond     Normal
hi link clojureRepeat   Normal

"------------------------------------------------------------------------------
" Ruby

hi link rubyOperator               Operator
hi link rubyInclude                Statement
hi link rubyMacro                  Statement
hi link rubyInterpolation          Special
hi link rubyInterpolationDelimiter Special
hi link rubySharpBang              Special
hi link rubyStringDelimiter        String

call s:h("rubySymbol", { "fg": s:Cyan })
hi link rubySymbolDelimiter        rubySymbol
hi link rubyPredefinedIdentifier   rubySymbol
hi link rubyPredefinedVariable     rubySymbol
hi link rubyPredefinedConstant     rubySymbol
hi link rubyPseudoVariable         rubySymbol

"------------------------------------------------------------------------------
" SQL

call s:h("sqlKeyword",      { "fg": s:Orange })
hi link sqlOperator  sqlKeyword
hi link sqlStatement sqlKeyword
hi link sqlType      sqlKeyword
hi link sqlFunction  sqlKeyword
hi link sqlSpecial   sqlKeyword
hi link Quote        String

"------------------------------------------------------------------------------
" OCaml

hi link ocamlConstructor Identifier

"------------------------------------------------------------------------------
" Markdown

hi link markdownCode      Statement
hi link markdownCodeBlock Statement

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

call s:h("DiffAdd",    {                "bg": s:Dark_Green })
call s:h("DiffDelete", { "fg": s:Black, "bg": s:Red })
call s:h("DiffChange", {                "bg": s:Dark_Grey })
call s:h("DiffText",   {                "bg": s:Dark_Red })

"------------------------------------------------------------------------------
" vim-gitgutter

call s:h("GitGutterAdd",          { "fg": s:Flourescent_Green, "bg": s:Black3 })
call s:h("GitGutterDelete",       { "fg": s:Pastel_Red,        "bg": s:Black3 })
call s:h("GitGutterChange",       { "fg": s:Orange,            "bg": s:Black3 })
call s:h("GitGutterChangeDelete", { "fg": s:Orange,            "bg": s:Black3 })

"------------------------------------------------------------------------------
" TagBar

call s:h("TagbarVisibilityPublic",    { "fg": s:Flourescent_Green })
call s:h("TagbarVisibilityPrivate",   { "fg": s:Pastel_Red })
call s:h("TagbarVisibilityProtected", { "fg": s:Orange })

"------------------------------------------------------------------------------
" gitCommit

call s:h("diffAdded",   { "fg": s:Flourescent_Green })
call s:h("diffRemoved", { "fg": s:Pastel_Red })
call s:h("diffChanged", { "fg": s:Orange })
hi link diffLine Constant

call s:h("gitcommitSummary", { "fg": s:Pale_Grey })
call s:h("gitcommitOverflow", { "fg": s:Pink })

"------------------------------------------------------------------------------
" Vim

hi link HelpCommand     Statement
hi link HelpExample     Statement
hi link vimCommand      Statement
hi link vimOption       Function
hi link vimCommentTitle Function

"------------------------------------------------------------------------------
" RainbowParentheses

call s:h("rainbowParens1", { "fg": s:Orange })
call s:h("rainbowParens2", { "fg": s:Flourescent_Green })
call s:h("rainbowParens3", { "fg": s:Light_Blue })
call s:h("rainbowParens4", { "fg": s:Pink })
call s:h("rainbowParens5", { "fg": s:Pale_Yellow })
