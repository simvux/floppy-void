local autopairs = require('nvim-autopairs')
autopairs.setup {
     check_ts = true,
     ts_config = {}
}
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
autopairs.add_rules {
  Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(opts) return opts.char == ">" end),
}

function load_lualine(theme)
    require('lualine').setup {
        options = {
            icons_enabled = false,
            theme = theme,
        },
        sections = {
        lualine_b = {},
        lualine_c = {{'filename', path = 3}},
        lualine_x = {'diagnostics', 'filetype'},
        }
    }
end

function load_lualine_by_name(theme)
    local lualine_purple_theme = {
      normal = {
        a = { fg = "#000000", bg = "#cc00cc", gui = 'bold' },
        b = { fg = "#000000", bg = "#b300b3" },
        c = { fg = "#ff1aff", bg = "#0f1216" },
      },
      insert = { a = { fg = "#ffabff", bg = "#8000ff", gui = 'bold' } },
      visual = { a = { fg = "#ffffff", bg = "#aaaaaa", gui = 'bold' } },
      replace = { a = { fg = "#ffffff", bg = "#0a0d11", gui = 'bold' } },
      inactive = {
        a = { fg = "#000000", bg = "#cc00cc", gui = 'bold' },
        b = { fg = "#000000", bg = "#b300b3" },
        c = { fg = "#b300b3", bg = "#0f1216" },
      },
    }

    local lualine_cyan_theme = {
      normal = {
        a = { fg = "#000000", bg = "#00afc5", gui = 'bold' },
        b = { fg = "#000000", bg = "#0098ac" },
        c = { fg = "#00c5df", bg = "#212734" },
      },
      insert = { a = { fg = "#000000", bg = "#3e7ec9", gui = 'bold' } },
      visual = { a = { fg = "#000000", bg = "#7e7ada", gui = 'bold' } },
      replace = { a = { fg = "#000000", bg = "#7e7ada", gui = 'bold' } },
      inactive = {
        a = { fg = "#000000", bg = "#212734", gui = 'bold' },
        b = { fg = "#000000", bg = "#b300b3" },
        c = { fg = "#54a1ff", bg = "#212734" },
      },
    }

    if theme == "purple_theme" then
        load_lualine(lualine_purple_theme);
    end
    if theme == "cyan_theme" then
        load_lualine(lualine_cyan_theme);
    end
end

local _ = load_lualine_by_name('cyan_theme');

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml", "comment", "bash", "asm", "cmake", "cpp", "css", "csv", "c", "elixir", "elm", "fsharp", "fortran", "go", "haskell", "html", "hyprlang", "readline", "zig" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
}
vim.api.nvim_set_hl(0, '@text.note', { link = 'Todo'})

require('lspconfig')['rust_analyzer'].setup{
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

-- Telescope
require('telescope').setup{
  defaults = {},
  pickers = {
    lsp_document_symbols = {
      initial_mode = "normal",
      theme = "dropdown",
      layout_config = {
          width = 0.6
      }
    },
    diagnostics = {
      initial_mode = "normal",
      theme = "dropdown",
      layout_config = {
          width = 0.6
      }
    },
    lsp_references = {
      initial_mode = "normal",
      theme = "dropdown",
      layout_config = {
          width = 0.6
      }
    },
    find_files = {
        initial_mode = "normal",
        theme = "dropdown",
        layout_config = {
            width = 0.6
        },
        mappings = {
            n = {
                ["h"] = function(prompt_bufnr)
                        local current_picker =
                            require("telescope.actions.state").get_current_picker(prompt_bufnr)
                        -- cwd is only set if passed as telescope option
                        local cwd = current_picker.cwd and tostring(current_picker.cwd)
                            or vim.loop.cwd()
                        local parent_dir = vim.fs.dirname(cwd)

                        require("telescope.actions").close(prompt_bufnr)
                        require("telescope.builtin").find_files {
                            prompt_title = vim.fs.basename(parent_dir),
                            cwd = parent_dir,
                        }
                    end,
                }
           }
      }
  },
  extensions = {}
}
local telescope = require('telescope.builtin')
vim.keymap.set('n', 'zi', function () 
    telescope.lsp_document_symbols(
        { symbols = {'function', 'method', 'class', 'impl', 'struct', 'object'}
        -- , ignore_symbols_sort = true
        }
    )
end)
vim.keymap.set('n', 'zf', telescope.find_files)
vim.keymap.set('n', 'zu', telescope.lsp_references)
vim.keymap.set('n', 'zd', function()
    telescope.diagnostics({severity_limit = "ERROR", sort_by = "severity"})
end)

-- Hide semantic highlights for functions
-- vim.api.nvim_set_hl(0, '@lsp.type.function', {})
-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

require'lspconfig'.html.setup{}
require('lspconfig')['eslint'].setup{}
require('lspconfig')['pyright'].setup{
    flags = lsp_flags,
}
require'lspconfig'.gopls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.luau_lsp.setup{}
vim.lsp.enable('elmls')
require'lspconfig'.hls.setup{}
require'lspconfig'.fortls.setup{
    cmd = {
        'fortls',
        '--hover_signature',
        '--hover_language=fortran',
        '--lowercase_intrinsics',
        '--use_signature_help',
        '--enable_code_actions'
    },
}
require'lspconfig'.lemminx.setup{
    filetypes = { 'rvsdg', 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
}
-- vim.lsp.enable('lemminx')

vim.api.nvim_create_user_command(
    'LuminaFormat',
    function()
        vim.api.nvim_command('silent write')
        -- vim.api.nvim_command('silent write! backup-before-format.lm')
        -- vim.cmd("silent !lumina fmt --file % > /tmp/formatfile-%.lm && mv /tmp/formatfile-%.lm %")
        vim.cmd("silent !lumina fmt --file % --overwrite")
        vim.cmd("e")
    end,
    {}
)
-- vim.lsp.omnifunc{}

-- vim.api.nvim_create_augroup("AutoFormat", {})
-- 
-- vim.api.nvim_create_autocmf(
--     "BufWritePost",
--     {
--         pattern = "*.lm",
--         group = "AutoFormat",
--         callback = function()
--             vim.cmd("");
--         end,
--     }
-- )

-- Language Server Mappings
local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'ze', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'zk', function()
    vim.diagnostic.goto_prev({
    float = false,
}) end, opts)
vim.keymap.set('n', 'zj', function()
    vim.diagnostic.goto_next({
    float = false,
}) end, opts)
-- vim.keymap.set('n', 'zd', function()
--     vim.diagnostic.setqflist({
--     -- severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }
--     severity = { vim.diagnostic.severity.ERROR }
-- }) end, opts)
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'zg', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'zh', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'za', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'zs', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'zr', vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', 'zu', vim.lsp.buf.references, bufopts)
-- vim.keymap.set('n', 'zf', function() vim.cmd('LuminaFormat') end, bufopts)
-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
})

-- Autocompletion is not provided by nvim-lspconfig, we need to use external plugin instead
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local cmp = require 'cmp'
local luasnip = require('luasnip')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
luasnip.add_snippets("rust", {
    s("impl fmt::Display", {
        t("impl fmt::Display for "),
        i(1),
        t({" {", "    "}),
        t({"fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {", "        "}),
        i(2),
        t({"", "    }", "}"})
    })
})

vim.diagnostic.config({
    virtual_text = true,
    signs = false,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
	scope = 'line',
	serverity = { min = 'Error' },
	border = 'single',
    },
})

-- Hack for not showing popup on rust-analyzer cancellation request
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

-- Changes so that the text only shows for errors and underlines are no longer shown for hints
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      min = "Warning",
    },
    virtual_text = {
      min = "Error",
    },
  }
)

-- File Navigation
require('fm-nvim').setup{
  mappings = {
    vert_split = "a",
    horz_split = "v",
    edit       = "e",
    ESC        = "q"
  }
}
