local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
	root_dir = function(fname)
		-- Only treat ~/.config/nvim as workspace for LuaLS
		local util = require("lspconfig.util")
		return util.root_pattern(".git", "lua", "init.lua")(fname) or vim.fn.expand("~/.config/nvim")
	end,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.config("ts_ls", {
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
vim.lsp.enable("ts_ls")

vim.lsp.config("pyright", {
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
vim.lsp.enable("pyright")

vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("gopls", {
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
vim.lsp.enable("gopls")

return M
