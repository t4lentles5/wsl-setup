return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"astro-ls",
			},
			automatic_installation = true,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"black",
				"shfmt",
				"stylua",
				"eslint_d",
			},
			auto_update = true,
			run_on_start = true,
		})

		local lspconfig = require("lspconfig")

		lspconfig.ts_ls.setup({})
		lspconfig.html.setup({})
		lspconfig.cssls.setup({})
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})
	end,
}
