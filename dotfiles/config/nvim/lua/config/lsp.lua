local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp._config.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp._config.ts_ls.setup({
	capabilities = capabilities,
	settings = {
		javascript = {
			preferences = {
				importModuleSpecifierPreference = "relative",
			},
		},
		typescript = {
			preferences = {
				importModuleSpecifierPreference = "relative",
			},
		},
	},
})

vim.lsp._config.pyright.setup({
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp._config.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
})

vim.lsp._config.gopls.setup({
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
})

return M
