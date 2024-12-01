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
require('lualine').setup {
    options = {
	icons_enabled = false,
	theme = lualine_purple_theme,
    },
    sections = {
	lualine_b = {},
	lualine_c = {{'filename', path = 3}},
	lualine_x = {'diagnostics', 'filetype'},
    }
}

require('lspconfig')['rust_analyzer'].setup{
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

-- Hide semantic highlights for functions
-- vim.api.nvim_set_hl(0, '@lsp.type.function', {})
-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

require('lspconfig')['pyright'].setup{
    flags = lsp_flags,
}
require'lspconfig'.gopls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.luau_lsp.setup{}
require'lspconfig'.elmls.setup{}
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
-- vim.lsp.omnifunc{}

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
vim.keymap.set('n', 'zd', function()
    vim.diagnostic.setqflist({
    severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }
    -- severity = { vim.diagnostic.severity.ERROR }
}) end, opts)
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'zg', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'zh', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'za', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'zs', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'zr', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', 'zu', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', 'zf', function() vim.lsp.buf.format { async = true } end, bufopts)
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
