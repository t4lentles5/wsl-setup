return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ahmedkhalf/project.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
			extensions = {
				projects = {},
			},
		})

		telescope.load_extension("projects")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>/", function()
			require("telescope.builtin").current_buffer_fuzzy_find()
		end, { desc = "Search in current buffer" })
		vim.keymap.set("n", "<leader>*", function()
			require("telescope.builtin").current_buffer_fuzzy_find({ default_text = vim.fn.expand("<cword>") })
		end, { desc = "Search word under cursor in current buffer" })

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep project" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
	end,
}
