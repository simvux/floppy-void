-- You probably always want to set this in your vim file
-- vim.opt.background = 'dark'
vim.g.colors_name = 'cyan_theme'

package.loaded['lush-themes.purple_theme'] = nil

-- include our theme file and pass it to lush to apply
require('lush')(require('lush-themes.cyan_theme'))
