return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				tailwindcss = {},
			},
		},
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
}
