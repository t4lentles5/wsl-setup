return {
	{
		"pmizio/typescript-tools.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		opts = {
			settings = {
				separate_diagnostic_server = true,
				publish_diagnostic_on = "insert_leave",
				expose_as_code_action = "all",
			},
		},
	},

	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
		},
		opts = {
			-- border = EcoVim.ui.float.border or "rounded", -- Valid window border style,
			show_unknown_classes = true, -- Shows the unknown classes popup
		},
	},

	{
		"laytan/tailwind-sorter.nvim",
		cmd = {
			"TailwindSort",
			"TailwindSortOnSaveToggle",
		},
		keys = {
			{ "<Leader>cS", "<CMD>TailwindSortOnSaveToggle<CR>", desc = "toggle Tailwind CSS classes sort on save" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build",
		config = true,
	},

	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		ft = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		config = true, -- run require("template-string").setup()
	},

	{
		"dmmulroy/tsc.nvim",
		cmd = { "TSC" },
		config = true,
	},

	{
		"dmmulroy/ts-error-translator.nvim",
		config = true,
	},
}
