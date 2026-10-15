--type conform.options
local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },

		sh = { "shfmt" },
    c_cpp = { "clang-format" }, -- Hack to force download.
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    rust = { "rustfmt", lsp_format = "fallback" },
  },
  formatters = {
      ["goimports-reviser"] = {
          prepend_args = { "-rm-unused" },
      },
      golines = {
          prepend_args = { "--max-len=80" },
      },
      black = {
          prepend_args = {
              "--fast",
              "--line-length",
              "80",
          },
      },
      isort = {
          prepend_args = {
              "--profile",
              "black",
          },
      },
  },
  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

	format_on_save = {
	  -- These options will be passed to conform.format()
	  timeout_ms = 500,
	  lsp_fallback = true,
	},
}

require("conform").setup(options)
