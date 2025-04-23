local lush = require('lush')

local hsl = lush.hsl

local strong_base = "#00dcf8"
local strong_0 = "#0098ac"
local strong_1 = "#00afc5"
local strong_2 = "#00c5df"
local strong_3 = strong_base
local strong_4 = "#13e4ff"
local strong_5 = "#2ce7ff"
local strong_6 = "#46eaff"

local weak_base = "#7aa6da"
local weak_0 = "#3e7ec9"
local weak_1 = "#528bcf"
local weak_2 = "#6699d4"
local weak_3 = weak_base
local weak_4 = "#8eb3e0"
local weak_5 = "#a2c1e5"
local weak_6 = "#b6ceeb"


local strong_foreground = "#00dcf8"
local weak_foreground   = "#7aa6da"

local weak_analogous_purple = "#7e7ada"
local green = "#44cc55"
local white = "#eaeaea"

-- local blue = "#00dcf8"
local red  = "#ff0080"

-- This is a comment

-- I personally really dislike semantic highlighting
-- Things changing color depending on semantics rather than syntax ruins the point for me
--
-- However; it does seem to be the direction things are going, and it's probably not worth
-- fighting the tide. 

local theme = lush(function(injected_functions) 
  local sym = injected_functions.sym

  return {
    Normal { fg = white },
    String { fg = weak_base },
    PreProc { fg = strong_5 },
    Type   { fg = strong_3 },
    Constant { fg = strong_2 },
    -- sym("@function.call") { fg = weak_analogous_purple },
    -- rustFoldBraces { fg = weak_2 },
    Operator { fg = weak_4 },
    Keyword { fg = strong_6 },
    Include { fg = weak_2 },
    Identifier { fg = weak_base },
    Delimiter { fg = weak_5 },
    Statement { fg = strong_3 },
    Todo { fg = strong_2 },
    Special { fg = Normal.fg },
    ErrorMsg { fg = red },
    Function { fg = strong_2 },
    DiagnosticError { fg = red }
  }
end)

return theme
