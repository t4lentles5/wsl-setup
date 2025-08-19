return {
	"tiagovla/tokyodark.nvim",
	opts = {
		transparent_background = true,
		gamma = 1.00,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			identifiers = { italic = true },
			functions = {},
			variables = {},
		},
		custom_highlights = function(highlights, palette)
			return highlights
		end,
		custom_palette = function(palette)
			return palette
		end,
		terminal_colors = false,
	},
	config = function(_, opts)
		vim.o.termguicolors = true
		require("tokyodark").setup(opts)
		vim.cmd([[colorscheme tokyodark]])
	end,
}
