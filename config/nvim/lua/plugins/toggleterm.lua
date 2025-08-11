return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-\>]],
      direction = "float",
      size = 20,
      persist_size = true,
      close_on_exit = true,
      shade_terminals = true,
      start_in_insert = true,

      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 0,
      },

      on_open = function(term)
        vim.api.nvim_win_set_option(term.window, "winhighlight", "Normal:Normal,FloatBorder:FloatBorder")
        vim.api.nvim_buf_set_option(term.bufnr, "filetype", "toggleterm")
      end,
    })
  end,
}
