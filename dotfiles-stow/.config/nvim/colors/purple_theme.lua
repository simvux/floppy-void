-- You probably always want to set this in your vim file
-- vim.opt.background = 'dark'
vim.g.colors_name = 'purple_theme'

package.loaded['purple_theme.purple_theme'] = nil

-- include our theme file and pass it to lush to apply
require('lush')(require('purple_theme.purple_theme'))
