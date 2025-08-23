return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "astro", "html", "javascriptreact", "typescriptreact" },
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			-- Aseguramos que formatting exista
			opts.formatting = opts.formatting or {}
			local format_kinds = opts.formatting.format

			opts.formatting.format = function(entry, item)
				if format_kinds then
					format_kinds(entry, item) -- añadir iconos si existe
				end
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end

			return opts
		end,
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
}
