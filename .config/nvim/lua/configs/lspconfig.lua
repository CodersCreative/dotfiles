-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "pyright",  "gopls", "gdtoolkit"}
local nvlsp = require "nvchad.configs.lspconfig"
local util = require("lspconfig/util")
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local port = os.getenv('GDScript_Port') or '6005'
lspconfig.gdscript.setup({
  capabilities = nvlsp.capabilities,
  cmd = vim.lsp.rpc.connect('127.0.0.1', port),
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
  on_attach = nvlsp.on_attach,
})

lspconfig.pyright.setup {
  capabilities = nvlsp.capabilities
}

lspconfig.rust_analyzer.setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
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

-- local dartExcludedFolders = {
--   vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
--   vim.fn.expand("$HOME/.pub-cache"),
--   vim.fn.expand("/opt/homebrew/"),
--   vim.fn.expand("$HOME/tools/flutter/"),
-- }

-- lspconfig["dcmls"].setup({
--   on_attach = nvlsp.on_attach,
--   capabilities = nvlsp.capabilities,
--   cmd = {
--     "dcm",
--     "start-server",
--   },
--   filetypes = { "dart", "yaml" },
--   -- settings = {
--   --   dart = {
--   --     analysisExcludedFolders = dartExcludedFolders,
--   --   },
--   -- },
-- })

lspconfig["dartls"].setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  cmd = {
    "dart",
    "language-server",
    "--protocol=lsp",
    -- "--port=8123",
    -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
  },
  filetypes = { "dart" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = false,
    flutterOutline = false,
  },
  settings = {
    dart = {
      -- analysisExcludedFolders = dartExcludedFolders,
      updateImportsOnRename = true,
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
