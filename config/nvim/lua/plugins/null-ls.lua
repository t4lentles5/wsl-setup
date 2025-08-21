return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local null_ls = require("null-ls")

			-- 🔹 Codespell (builtin, viene con null-ls)
			local sources = {
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.code_actions.codespell,
			}

			-- 🔹 CSpell (custom)
			local cspell = {
				method = null_ls.methods.DIAGNOSTICS,
				filetypes = { "javascript", "typescript", "typescriptreact", "json", "markdown", "text", "lua" },
				generator = null_ls.generator({
					command = "cspell",
					args = { "--no-color", "--no-progress", "--no-summary", "stdin" },
					to_stdin = true,
					from_stderr = false,
					format = "line",
					check_exit_code = function(code)
						return code <= 1
					end,
					on_output = function(line, params)
						local row, col, message = line:match("(%d+):(%d+)%s-(.*)")
						if row and col and message then
							return {
								row = tonumber(row),
								col = tonumber(col),
								message = message,
								source = "cspell",
							}
						end
					end,
				}),
			}

			table.insert(sources, cspell)
			opts.sources = vim.list_extend(opts.sources or {}, sources)
		end,
	},
}
