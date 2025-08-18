local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Save current file
map("n", "<leader>w", ":w<cr>", { desc = "Save file", remap = true })

-- ESC pressing jk
map("i", "jk", "<ESC>", { desc = "jk to esc", noremap = true })

-- Quit Neovim
map("n", "<leader>q", ":q<cr>", { desc = "Quit Neovim", remap = true })

-- Increment/decrement
map("n", "+", "<C-a>", { desc = "Increment numbers", noremap = true })
map("n", "-", "<C-x>", { desc = "Decrement numbers", noremap = true })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all", noremap = true })

-- Indenting
map("v", "<", "<gv", { desc = "Indenting", silent = true, noremap = true })
map("v", ">", ">gv", { desc = "Indenting", silent = true, noremap = true })

-- New tab
map("n", "te", ":tabedit")

-- Split window
map("n", "<leader>sh", ":split<Return><C-w>w", { desc = "splits horizontal", noremap = true })
map("n", "<leader>sv", ":vsplit<Return><C-w>w", { desc = "Split vertical", noremap = true })

-- Navigate vim panes better
map("n", "<C-k>", "<C-w>k", { desc = "Navigate up" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate down" })
map("n", "<C-h>", "<C-w>h", { desc = "Navigate left" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate right" })

-- Resize window
map("n", "<C-Up>", ":resize -3<CR>")
map("n", "<C-Down>", ":resize +3<CR>")
map("n", "<C-Left>", ":vertical resize -3<CR>")
map("n", "<C-Right>", ":vertical resize +3<CR>")

-- Bufferline
map("n", "<Tab>", ":BufferLineCycleNext<CR>")
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

-- Close buffer
map("n", "<leader>c", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Close Buffer (safe)" })

-- Explorer
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })

-- Snacks keymaps
-- Top Pickers & Explorer
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
-- map("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find Config File" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })

-- Git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })

-- LSP
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- Format
map({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- Diagnostics
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
  vim.tbl_extend("force", opts, { desc = "Diagnostics (Trouble)" }))
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  vim.tbl_extend("force", opts, { desc = "Buffer Diagnostics (Trouble)" }))
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",
  vim.tbl_extend("force", opts, { desc = "Location List (Trouble)" }))
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",
  vim.tbl_extend("force", opts, { desc = "Quickfix List (Trouble)" }))
