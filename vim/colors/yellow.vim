"------------------------------------------------------------------------------
" A minimal colorscheme indended to highlight only comments and strings.
" Color palette based on https://github.com/morhetz/gruvbox
"
" Author:  Matt Westcott <m.westcott@gmail.com> (mattwestcott.co.uk)
"------------------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "yellow"

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

let s:Black         = { "gui": "#282828", "cterm": "235" }
let s:Black2        = { "gui": "#3c3836", "cterm": "237" }
let s:Dark_Grey     = { "gui": "#504945", "cterm": "239" }
let s:Grey          = { "gui": "#7c6f64", "cterm": "243" }
let s:Grey2         = { "gui": "#928374", "cterm": "245" }
let s:Light_Grey    = { "gui": "#bdae93", "cterm": "248" }
let s:Pale_Grey     = { "gui": "#d5c4a1", "cterm": "250" }
let s:Almost_White  = { "gui": "#ebdbb2", "cterm": "229" }
let s:White         = { "gui": "#f6f6f6", "cterm": "231" }
let s:Pale_Blue     = { "gui": "#bce0ff", "cterm": "153" }
let s:Light_Blue    = { "gui": "#83a598", "cterm": "109" }
let s:Blue          = { "gui": "#458588", "cterm": "66"  }
let s:Blue_Black    = { "gui": "#616161", "cterm": "239" }
let s:Dark_Cyan     = { "gui": "#689d6a", "cterm": "72"  }
let s:Cyan          = { "gui": "#8ec07c", "cterm": "108" }
let s:Brown         = { "gui": "#be9873", "cterm": "137" }
let s:Pale_Yellow   = { "gui": "#fabd2f", "cterm": "214" }
let s:Dark_Yellow   = { "gui": "#d79921", "cterm": "172" }
let s:Orange        = { "gui": "#fe8019", "cterm": "208" }
let s:Dark_Orange   = { "gui": "#d65d0e", "cterm": "166" }
let s:Pastel_Red    = { "gui": "#fc7566", "cterm": "174" }
let s:Red           = { "gui": "#fb4934", "cterm": "167" }
let s:Dark_Red      = { "gui": "#cc241d", "cterm": "124" }
let s:Pink          = { "gui": "#d3869b", "cterm": "175" }
let s:Magenta       = { "gui": "#b16286", "cterm": "132" }
let s:Dark_Green    = { "gui": "#98971a", "cterm": "106" }
let s:Old_Green     = { "gui": "#719872", "cterm": "65"  }
let s:Bright_Green  = { "gui": "#b8bb26", "cterm": "142" }

"------------------------------------------------------------------------------
" Main highlights

call s:h("Cursor",       { "gui": "reverse" })
call s:h("Normal",       { "fg": s:Pale_Grey, "bg": s:Black2 })
call s:h("Function",     { "fg": s:Pale_Grey })
call s:h("Constant",     { "fg": s:Light_Blue })
call s:h("Comment",      { "fg": s:Grey2 })
call s:h("Special",      { "fg": s:Dark_Yellow })
call s:h("Delimiter",    { "fg": s:Pale_Grey })
call s:h("Operator",     { "fg": s:Pale_Grey })
call s:h("Statement",    { "fg": s:Pale_Grey })
call s:h("Keyword",      { "fg": s:Pale_Grey })
call s:h("Identifier",   { "fg": s:Pale_Grey })
call s:h("Type",         { "fg": s:Pale_Grey })
call s:h("PreProc",      { "fg": s:Pale_Grey })
call s:h("MatchParen",   { "fg": s:Pale_Yellow, "bg": s:Grey })
call s:h("CursorLineNr", { "fg": s:Pale_Grey })
call s:h("Underlined",   { "fg": s:Pale_Grey, "gui": "underline", "cterm": "underline"})

hi! link Boolean        Normal
hi! link Number         Normal
hi! link Float          Normal
hi! link SpecialKey     Function
hi! link Directory      Function
hi! link String         Constant
hi! link Character      Constant
hi! link Todo           Special
hi! link Debug          Special
hi! link SpecialChar    Special
hi! link SpecialComment Special
hi! link Tag            Special
hi! link Conditional    Statement
hi! link Exception      Statement
hi! link Label          Statement
hi! link Repeat         Statement
hi! link Define         Statement
hi! link StorageClass   Type
hi! link Structure      Type
hi! link Typedef        Type
hi! link Include        Preproc
hi! link Macro          Preproc
hi! link PreCondit      PreProc

"------------------------------------------------------------------------------
" Other groups

call s:h("CursorLine",   {                      "bg": s:Black2      })
call s:h("CursorColumn", {                      "bg": s:Black2      })
call s:h("VertSplit",    { "fg": s:Dark_Grey,   "bg": s:Dark_Grey   })
call s:h("StatusLine",   { "fg": s:Pale_Grey,   "bg": s:Dark_Grey   })
call s:h("StatusLineNC", { "fg": s:Grey,        "bg": s:Dark_Grey   })
call s:h("LineNr",       { "fg": s:Grey,        "bg": s:Black2      })
call s:h("SignColumn",   { "fg": s:Pale_Grey,   "bg": s:Black2      })
call s:h("Visual",       { "fg": s:Black,       "bg": s:Dark_Yellow })
call s:h("Search",       { "fg": s:Black,       "bg": s:Pale_Yellow })
call s:h("NonText",      { "fg": s:Pale_Grey                        })
call s:h("Title",        { "fg": s:Pale_Yellow                      })
call s:h("ModeMsg",      { "fg": s:Dark_Yellow                      })
call s:h("Error",        { "fg": s:Black,       "bg": s:Red         })
call s:h("ErrorMsg",     { "fg": s:Pale_Grey,   "bg": s:Red         })
call s:h("ColorColumn",  { "fg": s:Red,         "bg": s:Dark_Grey   })
call s:h("Pmenu",        { "fg": s:Light_Blue,  "bg": s:Dark_Grey   })
call s:h("PmenuSel",     { "fg": s:Dark_Yellow, "bg": s:Black2      })
call s:h("PmenuSbar",    { "fg": s:Dark_Yellow, "bg": s:Black       })
call s:h("PmenuThumb",   { "fg": s:Dark_Yellow, "bg": s:Black       })
call s:h("FoldColumn",   { "fg": s:Pink,        "bg": s:Black2      })
call s:h("Folded",       { "fg": s:Pink,        "bg": s:Black2      })
call s:h("TabLineFill",  {                      "bg": s:Dark_Grey   })
call s:h("TabLineSel",   { "fg": s:Light_Blue,  "bg": s:Dark_Grey   })
call s:h("TabLine",      { "fg": s:Grey,        "bg": s:Dark_Grey   })
call s:h("SpellBad",     { "fg": s:Black,       "bg": s:Red         })
call s:h("SpellCap",     { "fg": s:Black,       "bg": s:Pale_Yellow })
call s:h("SpellRare",    { "fg": s:Black,       "bg": s:Light_Blue  })
call s:h("SpellLocal",   { "fg": s:Black,       "bg": s:Pale_Yellow })

"------------------------------------------------------------------------------
" ALE

call s:h("ALEInfoSign",    { "fg": s:Dark_Green,  "bg": s:Black2 })
call s:h("ALEErrorSign",   { "fg": s:Red,         "bg": s:Black2 })
call s:h("ALEWarningSign", { "fg": s:Pale_Yellow, "bg": s:Black2 })

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
hi link pythonBuiltinObj Number
hi link pythonNone       Number
hi link pythonBoolean    Boolean
hi link pythonImport     Statement

"------------------------------------------------------------------------------
" Rust

call s:h("rustDerive",    { "fg": s:Dark_Yellow })
call s:h("rustAttribute", { "fg": s:Dark_Yellow })
hi link rustSelf        Normal
hi link rustEnumVariant Normal

"------------------------------------------------------------------------------
" Dhall

hi link dhallOperator     Special
hi link dhallBrackets     Special
hi link dhallSpecialLabel Special

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
hi link rubySymbolDelimiter      rubySymbol
hi link rubyPredefinedIdentifier rubySymbol
hi link rubyPredefinedVariable   rubySymbol
hi link rubyPredefinedConstant   rubySymbol
hi link rubyPseudoVariable       rubySymbol

"------------------------------------------------------------------------------
" SQL

call s:h("sqlKeyword",      { "fg": s:Pale_Yellow })
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
hi link mkdDelimiter      Comment

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
" Javascript/JSX

hi link JsThis Normal
hi link jsxBraces Normal

call s:h("xmlTag",          { "fg": s:Pink })
call s:h("xmlTagName",      { "fg": s:Pink })
call s:h("xmlAttrib",       { "fg": s:Pink })
call s:h("xmlAttribPunct",  { "fg": s:Pink })
call s:h("xmlEqual",        { "fg": s:Pink })

hi link htmlTag            xmlTag
hi link htmlEndTag         xmlTag
hi link htmlArg            xmlTag
hi link htmlTagName        xmlTag
hi link htmlSpecialTagName xmlTag
hi link htmlStatement      xmlTag

hi link jsxAttrib         xmlTag
hi link jsxAttribKeyword  xmlTag
hi link jsxTagName        xmlTag
hi link jsxComponentName  xmlTag
hi link jsxOpenPunct      xmlTag
hi link jsxClosePunct     xmlTag
hi link jsxSpreadOperator xmlTag
hi link jsxComment        xmlTag
hi link jsxCloseString    xmlTag
hi link jsxOpenTag        xmlTag
hi link jsxCloseTag       xmlTag
hi link jsxDot            xmlTag
hi link jsxNamespace      xmlTag
hi link jsxEqual          xmlTag

hi link jsonKeyword String
hi link jsonString  String
hi link jsonQuote   String

"------------------------------------------------------------------------------
" Lisp

hi link lispDecl   Normal
hi link lispFunc   Normal
hi link lispConcat Normal
hi link lispVar    Normal
hi link lispSymbol Normal

"------------------------------------------------------------------------------
" gitCommit

call s:h("diffAdded",   { "fg": s:Dark_Green  })
call s:h("diffRemoved", { "fg": s:Pastel_Red  })
call s:h("diffChanged", { "fg": s:Pale_Yellow })
hi link diffLine Constant

call s:h("gitcommitSummary",  { "fg": s:Pale_Grey })
call s:h("gitcommitOverflow", { "fg": s:Pink      })

"------------------------------------------------------------------------------
" Diff

call s:h("DiffAdd",    {                "bg": s:Dark_Green })
call s:h("DiffDelete", { "fg": s:Black, "bg": s:Red        })
call s:h("DiffChange", {                "bg": s:Dark_Grey  })
call s:h("DiffText",   {                "bg": s:Dark_Red   })

"------------------------------------------------------------------------------
" vim-gitgutter

call s:h("GitGutterAdd",          { "fg": s:Dark_Green,        "bg": s:Black2 })
call s:h("GitGutterDelete",       { "fg": s:Red,               "bg": s:Black2 })
call s:h("GitGutterChange",       { "fg": s:Pale_Yellow,       "bg": s:Black2 })
call s:h("GitGutterChangeDelete", { "fg": s:Pale_Yellow,       "bg": s:Black2 })

"------------------------------------------------------------------------------
" TagBar

call s:h("TagbarVisibilityPublic",    { "fg": s:Bright_Green })
call s:h("TagbarVisibilityPrivate",   { "fg": s:Red })
call s:h("TagbarVisibilityProtected", { "fg": s:Pale_Yellow })

"------------------------------------------------------------------------------
" Vim

hi link HelpCommand     Statement
hi link HelpExample     Statement
hi link vimCommand      Statement
hi link vimOption       Function
hi link vimCommentTitle Function


call s:h("IndentBlanklineChar", { "fg": s:Grey2, "bg": s:Black2 })
