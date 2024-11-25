local lush = require('lush')

local hsl = lush.hsl

local strong_foreground = "#ff00ff"
local weak_foreground   = "#ffabff"
local background        = "#0a0d11"
local pink_variantion   = "#ff89ff"


local mono0 = "#b300b3"
local mono1 = "#cc00cc"
local mono2 = "#e600e6"
local mono3 = "#ff00ff"
local mono4 = "#ff1aff"
local mono5 = "#ff33ff"
local mono6 = "#ff4dff"

local blue = "#8000ff"
local red  = "#ff0080"

-- This is a comment

local theme = lush(function() 
  return {
    Normal { fg = weak_foreground },
    String { fg = pink_variantion },
    Type   { fg = mono6 },
    Constant { fg = blue },
    Identifier { fg = mono1 },
    Statement { fg = mono4 },
    Todo { bg = blue },
    Special { fg = blue },
    Function { fg = mono3 }
  }
end)

return theme
