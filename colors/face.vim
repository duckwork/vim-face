" Name: vim-face colorscheme
" Author: Case Duckworth <acdw@acdw.net>
" URL:
" License:

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "face"

let s:none = "NONE"

function! s:HL(group, ...)
    " Arguments: group,                <- the group to highlight
    " link_group OR (                  <- link to another group
    " [ctermfg, guifg] OR ctermfg,     <- colors for foreground
    " [ctermbg, guibg] OR ctermfg,     <- colors for background
    " cterm/gui,                       <- formatting
    " guisp                            <- formatting color (underline)
    " )

    " All the xcolors, for easy lookup
    let xcolors = [ "#000000", "#800000", "#008000", "#808000", "#000080",
        \ "#800080", "#008080", "#c0c0c0", "#808080", "#ff0000", "#00ff00",
        \ "#ffff00", "#0000ff", "#ff00ff", "#00ffff", "#ffffff", "#000000",
        \ "#00005f", "#000087", "#0000af", "#0000d7", "#0000ff", "#005f00",
        \ "#005f5f", "#005f87", "#005faf", "#005fd7", "#005fff", "#008700",
        \ "#00875f", "#008787", "#0087af", "#0087d7", "#0087ff", "#00af00",
        \ "#00af5f", "#00af87", "#00afaf", "#00afd7", "#00afff", "#00d700",
        \ "#00d75f", "#00d787", "#00d7af", "#00d7d7", "#00d7ff", "#00ff00",
        \ "#00ff5f", "#00ff87", "#00ffaf", "#00ffd7", "#00ffff", "#5f0000",
        \ "#5f005f", "#5f0087", "#5f00af", "#5f00d7", "#5f00ff", "#5f5f00",
        \ "#5f5f5f", "#5f5f87", "#5f5faf", "#5f5fd7", "#5f5fff", "#5f8700",
        \ "#5f875f", "#5f8787", "#5f87af", "#5f87d7", "#5f87ff", "#5faf00",
        \ "#5faf5f", "#5faf87", "#5fafaf", "#5fafd7", "#5fafff", "#5fd700",
        \ "#5fd75f", "#5fd787", "#5fd7af", "#5fd7d7", "#5fd7ff", "#5fff00",
        \ "#5fff5f", "#5fff87", "#5fffaf", "#5fffd7", "#5fffff", "#870000",
        \ "#87005f", "#870087", "#8700af", "#8700d7", "#8700ff", "#875f00",
        \ "#875f5f", "#875f87", "#875faf", "#875fd7", "#875fff", "#878700",
        \ "#87875f", "#878787", "#8787af", "#8787d7", "#8787ff", "#87af00",
        \ "#87af5f", "#87af87", "#87afaf", "#87afd7", "#87afff", "#87d700",
        \ "#87d75f", "#87d787", "#87d7af", "#87d7d7", "#87d7ff", "#87ff00",
        \ "#87ff5f", "#87ff87", "#87ffaf", "#87ffd7", "#87ffff", "#af0000",
        \ "#af005f", "#af0087", "#af00af", "#af00d7", "#af00ff", "#af5f00",
        \ "#af5f5f", "#af5f87", "#af5faf", "#af5fd7", "#af5fff", "#af8700",
        \ "#af875f", "#af8787", "#af87af", "#af87d7", "#af87ff", "#afaf00",
        \ "#afaf5f", "#afaf87", "#afafaf", "#afafd7", "#afafff", "#afd700",
        \ "#afd75f", "#afd787", "#afd7af", "#afd7d7", "#afd7ff", "#afff00",
        \ "#afff5f", "#afff87", "#afffaf", "#afffd7", "#afffff", "#d70000",
        \ "#d7005f", "#d70087", "#d700af", "#d700d7", "#d700ff", "#d75f00",
        \ "#d75f5f", "#d75f87", "#d75faf", "#d75fd7", "#d75fff", "#d78700",
        \ "#d7875f", "#d78787", "#d787af", "#d787d7", "#d787ff", "#d7af00",
        \ "#d7af5f", "#d7af87", "#d7afaf", "#d7afd7", "#d7afff", "#d7d700",
        \ "#d7d75f", "#d7d787", "#d7d7af", "#d7d7d7", "#d7d7ff", "#d7ff00",
        \ "#d7ff5f", "#d7ff87", "#d7ffaf", "#d7ffd7", "#d7ffff", "#ff0000",
        \ "#ff005f", "#ff0087", "#ff00af", "#ff00d7", "#ff00ff", "#ff5f00",
        \ "#ff5f5f", "#ff5f87", "#ff5faf", "#ff5fd7", "#ff5fff", "#ff8700",
        \ "#ff875f", "#ff8787", "#ff87af", "#ff87d7", "#ff87ff", "#ffaf00",
        \ "#ffaf5f", "#ffaf87", "#ffafaf", "#ffafd7", "#ffafff", "#ffd700",
        \ "#ffd75f", "#ffd787", "#ffd7af", "#ffd7d7", "#ffd7ff", "#ffff00",
        \ "#ffff5f", "#ffff87", "#ffffaf", "#ffffd7", "#ffffff", "#080808",
        \ "#121212", "#1c1c1c", "#262626", "#303030", "#3a3a3a", "#444444",
        \ "#4e4e4e", "#585858", "#626262", "#6c6c6c", "#767676", "#808080",
        \ "#8a8a8a", "#949494", "#9e9e9e", "#a8a8a8", "#b2b2b2", "#bcbcbc",
        \ "#c6c6c6", "#d0d0d0", "#dadada", "#e4e4e4", "#eeeeee"
        \ ]

    " NONE is the same everywhere
    let nones = [s:none, s:none]

    " If there are no arguments, clear the highlight completely
    if a:0 < 1
        exe "hi" a:group
                    \ "ctermfg=NONE" "guifg=NONE"
                    \ "ctermbg=NONE" "guibg=NONE"
                    \ "cterm=NONE" "gui=NONE"
                    \ "guisp=NONE"
        return
    endif

    " If there"s one argument after group, and it"s a string,
    " link the highlighting
    if exists("a:1") && type(a:1) == type("")
        exe "hi! link" a:group a:1
        return
    endif

    " Foreground: expects a list of [ctermfg, guifg]
    if exists("a:1") && type(a:1) == type([]) && len(a:1) > 0
        let fgs = a:1
    elseif exists("a:1") && type(a:1) == type(0)
        let fgs = [a:1, xcolors[a:1]]
    else
        let fgs = nones
    endif

    " Background: expects a list of [ctermbg, guibg]
    if exists("a:2") && type(a:2) == type([]) && len(a:2) > 0
        let bgs = a:2
    elseif exists("a:2") && type(a:2) == type(0)
        let bgs = [a:2, xcolors[a:2]]
    else
        let bgs = nones
    endif

    " Formatting: expects one term (since it"s the same for cterm/gui)
    if exists("a:3")
        let fm = a:3
    else
        let fm = s:none
    endif

    " GuiSp: The color of the underlines and undercurls in the GUI
    if exists("a:4")
        let sp = a:4
    else
        let sp = s:none
    endif

    exe "hi" a:group
                \ "ctermfg=".fgs[0] "guifg=".fgs[1]
                \ "ctermbg=".bgs[0] "guibg=".bgs[1]
                \ "cterm=".fm "gui=".fm
                \ "guisp=".sp
endfunction

" Baseline
call s:HL("Normal", 16, 255)
call s:HL("NormalNC", 237)

" Syntactical elements
call s:HL("Comment", 238, [], "italic")
call s:HL("Constant")
call s:HL("String", "Constant")
call s:HL("Identifier")
call s:HL("Statement", [], [], "bold")
call s:HL("PreProc")
call s:HL("Type", [], [], "italic")
call s:HL("Special")
call s:HL("Delimiter", "Special")
call s:HL("SpecialComment", "Special")
call s:HL("Underlined", [], [], "underline")
call s:HL("Error", [], 204, "bold,underline")
call s:HL("Todo", [], 80, "underline")

" GUI elements
call s:HL("NonText", 250)
call s:HL("VertSplit", 250)
call s:HL("LineNr", 245)
call s:HL("CursorLineNr", 235, [], "bold")
call s:HL("CursorLine")
call s:HL("CursorColumn", "CursorLine")
call s:HL("ColorColumn", [], 250)
call s:HL("EndOfBuffer", "NonText")

call s:HL("Search", [], 220)
call s:HL("IncSearch", [], 220, "underline")
call s:HL("Substitute", [], 50)

call s:HL("StatusLine", 255, 233, "bold")
call s:HL("StatusLineNC", 255, 244)
call s:HL("TabLine", 255, 244, "italic")
call s:HL("TabLineSel", [], 255, "bold")
call s:HL("TabLineFill", [], 240)

call s:HL("DiffAdd", [], 112)
call s:HL("DiffDelete", [], 204)
call s:HL("DiffChange", [], 99)
call s:HL("DiffText", [], [], "underline")

call s:HL("WarningMsg", [], 215)
call s:HL("ErrorMsg", [], 204)

call s:HL("Folded", 235, 250, "italic")
call s:HL("FoldColumn", 235, 250)
call s:HL("SignColumn", "FoldColumn")

call s:HL("MatchParen", [], 250, "bold")

call s:HL("Pmenu", [], 225)
call s:HL("PmenuSel", [], 245, "bold")
call s:HL("PmenuThumb", [], 16)

call s:HL("Visual", [], 75)
call s:HL("VisualNOS", [], 69)

call s:HL("WildMenu", [], 75)
