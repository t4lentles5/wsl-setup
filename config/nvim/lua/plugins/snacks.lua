local excluded = {
	"node_modules/",
	".local/",
	".cache/",

	"package-lock.json",
	"pnpm-lock.yaml",
	"yarn.lock",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {

		animate = {},

		indent = {
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "linear",
				duration = {
					step = 20, -- ms per step
					total = 500, -- maximum duration
				},
			},
		},

		dashboard = {
			width = 50,
			sections = {
				{ section = "header" },
				{ section = "keys",   gap = 1, padding = 1 },
				{ section = "startup" },
				{
					section = "terminal",
					cmd = "pokemon-colorscripts -n articuno --no-title; sleep .0",
					pane = 2,
					indent = 0,
					height = 25,
				},
			},
		},

		picker = {
			sources = {
				explorer = {
					auto_close = false,
					hidden = true,
					ignored = true,

					layout = {
						layout = { position = "left" },
					},
				},
				files = {
					hidden = true,
					ignored = true,
					exclude = excluded,
				},
			},
			hidden = true,
			ignored = true,
		},

		scroll = {},
	},
}
