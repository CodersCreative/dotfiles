local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require("lspconfig/util")
local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- local port = os.getenv('GDScript_Port') or 6005
-- lspconfig.gdscript.setup({
--   capabilities = capabilities,
--   cmd = vim.lsp.rpc.connect('127.0.0.1', port),
--   root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
--   on_attach = on_attach,
-- })

lspconfig.pyright.setup {
  capabilities = capabilities
}

-- lspconfig.gdscript.setup ({
--   capabilities = capabilities
--   on_attach = on_attach,
-- })

-- lspconfig.efm.setup({
--   on_attach = on_attach,
--   flags = {
--     debounce_text_changes = 150,
--   },
--
--   init_options = {documentFormatting = true},
--   settings = {
--     rootMarkers = {".git/"},
--     languages = {
--       gdscript = {
--         {formatCommand = "gdformat -l 80 -", formatStdin = true}
--       },
--     },
-- })

lspconfig.cal_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"cal", "cl", "lua"},
  cmd = {"cal-lsp"},
  root_dir = util.root_pattern("main.cl", "test.cl", ".git"),
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      }
    }
  }
})

lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
        },
    },
})
-- 
--
-- lspconfig.pyright.setup { blabla}
